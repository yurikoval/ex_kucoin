defmodule ExKucoin.Api.Private do
  @moduledoc """
  Interface for authenticated HTTP requests
  """

  import ExKucoin.Api
  alias ExKucoin.Config

  @type path :: String.t()
  @type params :: map | [map]
  @type config :: ExKucoin.Config.t()
  @type response :: ExKucoin.Api.response()

  @spec get(path, params, config | nil) :: response
  def get(path, params \\ %{}, config \\ nil) do
    config = Config.config_or_env_config(config)
    qs = query_string(path, params)

    qs
    |> url(config)
    |> HTTPoison.get(headers("GET", qs, %{}, config), request_options())
    |> parse_response()
  end

  @spec post(path, params, config | nil) :: response
  def post(path, params \\ %{}, config \\ nil) do
    config = Config.config_or_env_config(config)

    path
    |> url(config)
    |> HTTPoison.post(
      Jason.encode!(params),
      headers("POST", path, params, config),
      request_options()
    )
    |> parse_response()
  end

  @spec delete(path, config | nil) :: response
  def delete(path, config \\ nil) do
    config = Config.config_or_env_config(config)

    path
    |> url(config)
    |> HTTPoison.delete(headers("DELETE", path, %{}, config), request_options())
    |> parse_response()
  end

  defp headers(method, path, body, config) do
    timestamp = ExKucoin.Auth.timestamp()
    signed = ExKucoin.Auth.sign(timestamp, method, path, body, config.api_secret)
    passphrase = ExKucoin.Auth.encrypt(config.api_passphrase, config.api_secret)

    [
      "Content-Type": "application/json",
      "KC-API-KEY": config.api_key,
      "KC-API-SIGN": signed,
      "KC-API-TIMESTAMP": timestamp,
      "KC-API-PASSPHRASE": passphrase,
      "KC-API-KEY-VERSION": "2"
    ]
  end
end
