defmodule ExKucoin.Market.Symbol do
  @moduledoc """
  Retrieves symbols [API Docs](https://docs.kucoin.com/#symbols-amp-ticker)
  """
  import ExKucoin.Api.Public

  @type market :: String.t()

  @doc """
  Retrieve all symbols

  # Examples

  ## Retrieve all symbols

    iex> ExKucoin.Market.Symbol.all()
    [
      %{
        "symbol" => "BTC-USDT",
        "name" => "BTC-USDT",
        "baseCurrency" => "BTC",
        "quoteCurrency" => "USDT",
        "baseMinSize" => "0.00000001",
        "quoteMinSize" => "0.01",
        "baseMaxSize" => "10000",
        "quoteMaxSize" => "100000",
        "baseIncrement" => "0.00000001",
        "quoteIncrement" => "0.01",
        "priceIncrement" => "0.00000001",
        "feeCurrency" => "USDT",
        "enableTrading" => true
      }
    ]

  ## Retrieve symbol from given market

    iex> ExKucoin.Market.Symbol.all("BTC-USDT")
    [
      %{
        "symbol" => "BTC-USDT",
        "name" => "BTC-USDT",
        "baseCurrency" => "BTC",
        "quoteCurrency" => "USDT",
        "baseMinSize" => "0.00000001",
        "quoteMinSize" => "0.01",
        "baseMaxSize" => "10000",
        "quoteMaxSize" => "100000",
        "baseIncrement" => "0.00000001",
        "quoteIncrement" => "0.01",
        "priceIncrement" => "0.00000001",
        "feeCurrency" => "USDT",
        "enableTrading" => true
      }
    ]
  """
  @spec all(market | nil) :: list
  def all(market \\ nil) do
    params =
      if market do
        %{market: market}
      else
        %{}
      end

    get("/api/v1/symbols", params)
  end
end
