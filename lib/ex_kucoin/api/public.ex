defmodule ExKucoin.Api.Public do
  @moduledoc """
  Interface for public HTTP requests
  """

  import ExKucoin.Api
  alias ExKucoin.Config

  @type path :: String.t()
  @type params :: map | [map]
  @type config :: ExKucoin.Config.t()
  @type response :: ExKucoin.Api.response()

  @headers ["Content-Type": "application/json"]

  def get(path, params \\ %{}, config \\ nil) do
    config = Config.config_or_env_config(config)
    qs = query_string(path, params)

    qs
    |> url(config)
    |> HTTPoison.get(@headers, request_options())
    |> parse_response()
  end

  @spec post(path, params, config | nil) :: response
  def post(path, params \\ %{}, config \\ nil) do
    config = Config.config_or_env_config(config)

    path
    |> url(config)
    |> HTTPoison.post(Jason.encode!(params), @headers, request_options())
    |> parse_response()
  end
end
