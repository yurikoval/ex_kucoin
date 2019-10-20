defmodule ExKucoin.WebSocket.PublicTest do
  use ExUnit.Case

  import TestHelper

  alias ExKucoin.WebSocket.Public, as: Api

  describe ".endpoint" do
    test "returns endpoint info" do
      mocked = %{
        "code" => "200000",
        "data" => %{
          "instanceServers" => [
            %{
              "pingInterval" => 50_000,
              "endpoint" => "wss://push1-v2.kucoin.com/endpoint",
              "protocol" => "websocket",
              "encrypt" => true,
              "pingTimeout" => 10_000
            }
          ],
          "token" =>
            "vYNlCtbz4XNJ1QncwWilJnBtmmfe4geLQDUA62kKJsDChc6I4bRDQc73JfIrlFaVYIAE0Gv2--MROnLAgjVsWkcDq_MuG7qV7EktfCEIphiqnlfpQn4Ybg==.IoORVxR2LmKV7_maOR9xOg=="
        }
      }

      response = http_response(mocked, 200)

      with_mock_request(:post, response, fn ->
        assert {:ok, returned} = Api.endpoint()
        assert returned == mocked
      end)
    end
  end
end
