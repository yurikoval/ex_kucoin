defmodule ExKucoin.Market.OrderBook do
  @moduledoc """
  Retrieves order books [API Docs](https://docs.kucoin.com/#get-part-order-book-aggregated)
  """
  import ExKucoin.Api.Public

  @type pair :: String.t()
  @type depth :: 20 | 100 | nil

  @doc """
  Retrieve Level 2 order book data

  Aggregation support is only for 20 and 100

  # Examples

  ## Full Order Book

    iex> ExKucoin.Market.OrderBook.level2("BTC-USDT")
    %{
      "sequence" => "3262786978",
      "time" => 1_550_653_727_731,
      "bids" => [["6500.12", "0.45054140"], ["6500.11", "0.45054140"]],
      "asks" => [["6500.16", "0.57753524"], ["6500.15", "0.57753524"]]
    }

  ## Aggregated Order Book (20)

    iex> ExKucoin.Market.OrderBook.level2("BTC-USDT", 20)
    %{
      "sequence" => "3262786978",
      "time" => 1_550_653_727_731,
      "bids" => [["6500.12", "0.45054140"], ["6500.11", "0.45054140"]],
      "asks" => [["6500.16", "0.57753524"], ["6500.15", "0.57753524"]]
    }

  ## Aggregated Order Book (100)

    iex> ExKucoin.Market.OrderBook.level2("BTC-USDT", 100)
    %{
      "sequence" => "3262786978",
      "time" => 1_550_653_727_731,
      "bids" => [["6500.12", "0.45054140"], ["6500.11", "0.45054140"]],
      "asks" => [["6500.16", "0.57753524"], ["6500.15", "0.57753524"]]
    }


  """
  @spec level2(pair, depth) :: map
  def level2(pair, depth \\ nil) do
    case depth do
      20 -> "/api/v1/market/orderbook/level2_20"
      100 -> "/api/v1/market/orderbook/level2_100"
      _ -> "/api/v2/market/orderbook/level2"
    end
    |> get(%{symbol: pair})
  end
end
