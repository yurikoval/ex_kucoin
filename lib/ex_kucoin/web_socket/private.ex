defmodule ExKucoin.WebSocket.Private do
  @moduledoc """
  Retrieve private WebSocket endpoint information

  [API docs](https://docs.kucoin.com/#apply-connect-token)
  """
  import ExKucoin.Api.Private

  @doc """
  Fetch private WebSocket endpoint info

  # Examples

  iex> ExKucoin.WebSocket.Private.endpoint()
  {:ok,
   %{
     "code" => "200000",
     "data" => %{
       "instanceServers" => [
   %{
     "encrypt" => true,
     "endpoint" => "wss://ws-api.kucoin.com/endpoint",
     "pingInterval" => 18000,
     "pingTimeout" => 10000,
     "protocol" => "websocket"
   }
       ],
       "token" => "2neAiuYvAU737TOajb2U3uT8AEZqSWYe0fBD4LoHuXJDSC7gIzJiH4kNTWhCPISWo6nDpAe7aUaafcTuDcaTb9Y9HDQx1qgfCXBoSsKykcRgDIupKTmYlnwZIngtMdMrjqPnP-biofGYc9o00VDGKWT05Kg2glnDJBvJHl5Vs9Y=.Fq059TQcs0a_KI7plBcacA=="
    }
  }}
  """
  def endpoint do
    post("/api/v1/bullet-private")
  end
end
