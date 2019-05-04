use Mix.Config

config :ex_kucoin,
  api_key: System.get_env("KUCOIN_API_KEY"),
  api_secret: System.get_env("KUCOIN_API_SECRET"),
  api_passphrase: System.get_env("KUCOIN_API_PASSPHRASE")
