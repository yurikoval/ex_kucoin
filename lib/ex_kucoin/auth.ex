defmodule ExKucoin.Auth do
  @moduledoc """
  Handle request signing for API Authentication
  """

  @spec timestamp :: String.t()
  def timestamp, do: :os.system_time(:millisecond) |> Integer.to_string()

  @spec sign(String.t(), String.t(), String.t(), map | [map], String.t()) :: String.t()
  def sign(timestamp, method, path, body, api_secret) do
    body =
      if Enum.empty?(body) and method in ["GET", "DELETE"] do
        ""
      else
        Jason.encode!(body)
      end

    "#{timestamp}#{method}#{path}#{body}"
    |> encrypt(api_secret)
  end

  @spec encrypt(String.t(), String.t()) :: String.t()
  def encrypt(data, secret), do: :crypto.mac(:hmac, :sha256, secret, data) |> Base.encode64()
end
