defmodule WebSocketWrapper do
  @moduledoc false

  require Logger
  use ExKucoin.WebSocket
end

defmodule ExKucoin.WebSocketTest do
  @moduledoc false

  use ExUnit.Case, async: true

  setup do
    channels = ["/market/ticker:ETH-BTC"]

    {:ok, socket} =
      WebSocketWrapper.start_link(%{
        channels: channels,
        config: %{access_keys: ["OK_1_API_KEY", "OK_1_API_SECRET", "OK_1_API_PASSPHRASE"]}
      })

    {:ok, socket: socket, state: :sys.get_state(socket)}
  end

  describe "initial state" do
    test "get state", %{state: state} do
      assert state == %{
               channels: ["/market/ticker:ETH-BTC"],
               private_channels: [],
               config: %{
                 access_keys: ["OK_1_API_KEY", "OK_1_API_SECRET", "OK_1_API_PASSPHRASE"]
               },
               heartbeat: 0
             }
    end
  end
end
