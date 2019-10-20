# ExKucoin

KuCoin API client for Elixir.

[![Build Status](https://travis-ci.com/yurikoval/ex_kucoin.svg?branch=master)](https://travis-ci.com/yurikoval/ex_kucoin)

- [API Docs](https://docs.kucoin.com/)
- [Full Documentation](https://hexdocs.pm/ex_kucoin/ExKucoin.html)

## Installation

List the Hex package in your application dependencies.

```elixir
def deps do
  [{:ex_kucoin, "~> 0.0.3"}]
end
```

Run `mix deps.get` to install.

## Configuration

Static API Key is the key you setup once and would never change. And this is what we need for most cases.

Add the following configuration variables in your config/config.exs file:

```elixir
use Mix.Config

config :ex_kucoin, api_key:        {:system, "KUCOIN_API_KEY"},
                 api_secret:     {:system, "KUCOIN_API_SECRET"},
                 api_passphrase: {:system, "KUCOIN_API_PASSPHRASE"}
```

Alternatively to hard coding credentials, the recommended approach is
to use environment variables as follows:

```elixir
use Mix.Config

config :ex_kucoin, api_key:        System.get_env("KUCOIN_API_KEY"),
                 api_secret:     System.get_env("KUCOIN_API_SECRET"),
                 api_passphrase: System.get_env("KUCOIN_API_PASSPHRASE")
```

#### Websocket

During the setup you can pass the access keys as argument. Ex:

```elixir
defmodule WsWrapper do
  @moduledoc false

  require Logger
  use ExKucoin.WebSocket
end
```

## Usage

TODO

## License

MIT
