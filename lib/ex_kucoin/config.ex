defmodule ExKucoin.Config do
  @moduledoc """
  Stores configuration variables for signing authenticated requests to API.
  """

  @type t :: %ExKucoin.Config{
          api_key: String.t(),
          api_secret: String.t(),
          api_passphrase: String.t(),
          api_url: String.t()
        }

  @default_api_url "https://api.kucoin.com"
  defstruct [:api_key, :api_secret, :api_passphrase, api_url: @default_api_url]

  def config_or_env_config(nil) do
    %__MODULE__{
      api_key: api_key(),
      api_secret: api_secret(),
      api_passphrase: api_passphrase(),
      api_url: api_url()
    }
  end

  def config_or_env_config(%{
        access_keys: [api_key_access, api_secret_access, api_passphrase_access]
      }) do
    %__MODULE__{
      api_key: api_key(api_key_access),
      api_secret: api_secret(api_secret_access),
      api_passphrase: api_passphrase(api_passphrase_access),
      api_url: api_url()
    }
  end

  def config_or_env_config(config), do: config

  def api_key, do: from_env(:ex_kucoin, :api_key)

  @spec api_key(atom) :: String.t()
  def api_key(access_key), do: from_env(access_key, :system)

  def api_secret, do: from_env(:ex_kucoin, :api_secret)

  @spec api_secret(atom) :: String.t()
  def api_secret(access_key), do: from_env(access_key, :system)

  def api_passphrase, do: from_env(:ex_kucoin, :api_passphrase)

  @spec api_passphrase(atom) :: String.t()
  def api_passphrase(access_key), do: from_env(access_key, :system)

  def api_url, do: from_env(:ex_kucoin, :api_url, @default_api_url)

  defp from_env(key, :system) do
    System.get_env(key)
  end

  defp from_env(otp_app, key, default \\ nil)

  defp from_env(otp_app, key, default) do
    otp_app
    |> Application.get_env(key, default)
    |> read_from_system(default)
  end

  defp read_from_system({:system, value}, default), do: value || default
  defp read_from_system(value, _default), do: value
end
