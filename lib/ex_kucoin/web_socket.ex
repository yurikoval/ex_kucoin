defmodule ExKucoin.WebSocket do
  @moduledoc false

  import Logger, only: [info: 1, warn: 1]
  import Process, only: [send_after: 3]

  # Client API
  defmacro __using__(_opts) do
    quote do
      use WebSockex
      alias ExKucoin.Config

      @type api_url :: String.t()

      def start_link(args \\ %{}) do
        name = args[:name] || __MODULE__
        state = Map.merge(%{heartbeat: 0, channels: [], private_channels: []}, args)
        WebSockex.start_link(get_public_endpoint(), __MODULE__, state, name: name)
      end

      def handle_connect(_conn, state) do
        :ok = info("KuCoin Connected!")
        send(self(), :ws_subscribe)
        send_after(self(), {:heartbeat, :ping, 1}, 20_000)
        {:ok, state}
      end

      def handle_info(
            :ws_subscribe,
            %{private_channels: private_channels, channels: channels} = state
          ) do
        channels |> Enum.each(&subscribe(self(), &1, false))
        private_channels |> Enum.each(&subscribe(self(), &1, true))
        {:ok, state}
      end

      def handle_info({:ws_reply, frame}, state) do
        {:reply, frame, state}
      end

      def handle_info(
            {:heartbeat, :ping, expected_heartbeat},
            %{heartbeat: heartbeat} = state
          ) do
        if heartbeat >= expected_heartbeat do
          send_after(self(), {:heartbeat, :ping, heartbeat + 1}, 1_000)
          {:ok, state}
        else
          send_after(self(), {:heartbeat, :pong, heartbeat + 1}, 4_000)

          ping =
            Jason.encode!(%{
              "id" => random_string(),
              "type" => "ping"
            })

          {:reply, {:text, ping}, state}
        end
      end

      def handle_info(
            {:heartbeat, :pong, expected_heartbeat},
            %{heartbeat: heartbeat} = state
          ) do
        if heartbeat >= expected_heartbeat do
          send_after(self(), {:heartbeat, :ping, heartbeat + 1}, 1_000)
          {:ok, state}
        else
          :ok = warn("#{__MODULE__} terminated due to " <> "no heartbeat ##{heartbeat}")
          {:close, state}
        end
      end

      def handle_frame({:text, data}, state) do
        json = Jason.decode!(data)

        case json do
          %{"type" => "pong"} ->
            {:ok, inc_heartbeat(state)}

          data ->
            handle_response(json, state)
        end
      end

      def handle_response(resp, state) do
        :ok = info("#{__MODULE__} received response: #{inspect(resp)}")
        {:ok, state}
      end

      def handle_disconnect(resp, state) do
        :ok = info("KuCoin Disconnected! #{inspect(resp)}")
        {:ok, state}
      end

      def terminate({:local, :normal}, %{catch_terminate: pid}),
        do: send(pid, :normal_close_terminate)

      def terminate(_, %{catch_terminate: pid}), do: send(pid, :terminate)
      def terminate(_, _), do: :ok

      # Helpers

      defp subscribe(server, channel, is_private) do
        params =
          Jason.encode!(%{
            "id" => random_string(),
            "type" => "subscribe",
            "topic" => channel,
            "privateChannel" => is_private,
            "response" => true
          })

        send(server, {:ws_reply, {:text, params}})
      end

      defp random_string do
        :crypto.strong_rand_bytes(8) |> Base.url_encode64()
      end

      defp inc_heartbeat(%{heartbeat: heartbeat} = state) do
        Map.put(state, :heartbeat, heartbeat + 1)
      end

      @spec get_public_endpoint() :: api_url
      defp get_public_endpoint() do
        {:ok, %{"code" => "200000", "data" => %{"token" => token, "instanceServers" => servers}}} =
          ExKucoin.WebSocket.Public.endpoint()

        %{"endpoint" => api_url} = hd(servers)
        "#{api_url}?token=#{token}"
      end

      defoverridable handle_connect: 2, handle_disconnect: 2, handle_response: 2
    end
  end
end
