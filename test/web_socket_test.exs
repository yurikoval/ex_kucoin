defmodule WebSocketWrapper do
  @moduledoc false

  require Logger
  use ExKucoin.WebSocket
end

defmodule ExKucoin.WebSocketTest do
  @moduledoc false

  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    config = %ExKucoin.Config{
      api_key: System.get_env("API_KEY") || "XXX",
      api_secret: System.get_env("API_SECRET") || "XXX",
      api_passphrase: System.get_env("API_PASSPHRASE") || "XXX",
      api_url: "https://openapi-sandbox.kucoin.com"
    }

    %{config: config}
  end

  describe "initial state" do
    test "get state", %{config: config} do
      channels = ["/market/ticker:ETH-BTC"]

      use_cassette "websocket/boot" do
        socket =
          start_supervised!({
            WebSocketWrapper,
            %{
              channels: channels,
              config: config
            }
          })

        assert :sys.get_state(socket) == %{
                 channels: ["/market/ticker:ETH-BTC"],
                 private_channels: [],
                 config: config,
                 heartbeat: 0
               }
      end
    end
  end
end
