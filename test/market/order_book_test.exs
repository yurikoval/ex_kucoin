defmodule ExKucoin.Market.OrderBookTest do
  use ExUnit.Case
  import TestHelper
  alias ExKucoin.Market.OrderBook, as: Api

  describe ".level2" do
    test "returns full order book" do
      mocked = %{
        "sequence" => "3262786978",
        "time" => 1_550_653_727_731,
        "bids" => [["6500.12", "0.45054140"], ["6500.11", "0.45054140"]],
        "asks" => [["6500.16", "0.57753524"], ["6500.15", "0.57753524"]]
      }

      response = http_response(mocked, 200)

      with_mock_request(:get, response, fn ->
        assert {:ok, returned} = Api.level2("ETH-BTC")
        assert returned == mocked
      end)
    end

    test "returns aggregated order book" do
      mocked = %{
        "sequence" => "3262786978",
        "time" => 1_550_653_727_731,
        "bids" => [["6500.12", "0.45054140"], ["6500.11", "0.45054140"]],
        "asks" => [["6500.16", "0.57753524"], ["6500.15", "0.57753524"]]
      }

      response = http_response(mocked, 200)

      with_mock_request(:get, response, fn ->
        assert {:ok, returned} = Api.level2("ETH-BTC", 20)
        assert returned == mocked
      end)

      with_mock_request(:get, response, fn ->
        assert {:ok, returned} = Api.level2("ETH-BTC", 100)
        assert returned == mocked
      end)
    end
  end
end
