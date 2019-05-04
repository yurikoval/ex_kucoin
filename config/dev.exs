use Mix.Config

# Read from environment variables
config :ex_kucoin,
  api_key: System.get_env("KUCOIN_API_KEY"),
  api_secret: System.get_env("KUCOIN_API_SECRET"),
  api_passphrase: System.get_env("KUCOIN_API_PASSPHRASE")

# Or replace "KUCOIN_*" values to define here in config file
# config :ex_kucoin, api_key:        {:system, "KUCOIN_API_KEY"},
#                  api_secret:     {:system, "KUCOIN_API_SECRET"},
#                  api_passphrase: {:system, "KUCOIN_API_PASSPHRASE"}
