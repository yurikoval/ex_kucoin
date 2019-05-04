defmodule ExKucoin.WebSocket.Public do
  @moduledoc """
  Retrieve WebSocket endpoint information

  [API docs](https://docs.kucoin.com/#apply-connect-token)
  """
  import ExKucoin.Api.Public

  @doc """
  Fetch public WebSocket endpoint info

  # Examples

      iex> ExKucoin.WebSocket.Public.endpoint()
      %{
        "code" => "200000",
        "data" => %{
          "instanceServers" => [
              %{
                "pingInterval" => 50000,
                "endpoint" => "wss://push1-v2.kucoin.com/endpoint",
                "protocol" => "websocket",
                "encrypt" => true,
                "pingTimeout" => 10000
              }
          ],
          "token" => "vYNlCtbz4XNJ1QncwWilJnBtmmfe4geLQDUA62kKJsDChc6I4bRDQc73JfIrlFaVYIAE0Gv2--MROnLAgjVsWkcDq_MuG7qV7EktfCEIphiqnlfpQn4Ybg==.IoORVxR2LmKV7_maOR9xOg=="
        }
      }
  """
  def endpoint do
    post("/api/v1/bullet-public")
  end
end
