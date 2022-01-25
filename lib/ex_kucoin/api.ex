defmodule ExKucoin.Api do
  @moduledoc """
  API Base
  """

  @type path :: String.t()
  @type config :: ExKucoin.Config.t()
  @type params :: map
  @type status_code :: integer
  @type body :: term
  @type response :: {:ok, term} | {:error, term} | {:error, body, status_code}

  @spec url(path, config) :: String.t()
  def url(path, config), do: config.api_url <> path

  @spec query_string(path, params) :: String.t()
  def query_string(path, params) when map_size(params) == 0, do: path

  def query_string(path, params) do
    query = Enum.map_join(params, "&", fn {key, val} -> "#{key}=#{val}" end)
    path <> "?" <> query
  end

  @spec parse_response(
          {:ok, HTTPoison.Response.t() | HTTPoison.AsyncResponse.t()}
          | {:error, HTTPoison.Error.t()}
        ) :: response
  def parse_response(response) do
    case response do
      {:ok, %HTTPoison.Response{body: body, status_code: status_code}} ->
        if status_code in 200..299 do
          {:ok, Jason.decode!(body)}
        else
          case Jason.decode(body) do
            {:ok, json} -> {:error, {json["code"], json["message"]}, status_code}
            {:error, _} -> {:error, body, status_code}
          end
        end

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  def request_options do
    [ssl: [{:versions, [:"tlsv1.2"]}]]
  end
end
