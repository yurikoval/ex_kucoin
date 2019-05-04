use Mix.Config

config :ex_kucoin,
  api_key: {:system, "KUCOIN_API_KEY"},
  api_secret: {:system, "KUCOIN_API_SECRET"},
  api_passphrase: {:system, "KUCOIN_API_PASSPHRASE"},
  api_url: {:system, "https://openapi-sandbox.kucoin.com"}
