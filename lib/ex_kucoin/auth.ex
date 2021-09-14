defmodule ExKucoin.Auth do
  @moduledoc """
  Handle request signing for API Authentication
  """

  @spec timestamp :: String.t()
  def timestamp, do: :os.system_time(:millisecond) |> Integer.to_string()

  @spec sign(String.t(), String.t(), String.t(), map | [map], String.t()) :: String.t()
  def sign(timestamp, method, path, body, api_secret) do
    body = if Enum.empty?(body), do: "", else: Jason.encode!(body)
    data = "#{timestamp}#{method}#{path}#{body}"

    :crypto.mac(:hmac, :sha256, api_secret, data)
    |> Base.encode64()
  end
end
