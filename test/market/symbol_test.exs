defmodule ExKucoin.Market.SymbolTest do
  use ExUnit.Case
  import TestHelper
  alias ExKucoin.Market.Symbol, as: Api

  describe ".all" do
    test "returns all symbols" do
      mocked = [
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

      response = http_response(mocked, 200)

      with_mock_request(:get, response, fn ->
        assert {:ok, returned} = Api.all()
        assert returned == mocked
      end)
    end

    test "returns all symbols matching the market" do
      mocked = [
        %{
          "code" => "200000",
          "data" => [
            %{
              "baseCurrency" => "KCS",
              "baseIncrement" => "0.0000001",
              "baseMaxSize" => "99999999",
              "baseMinSize" => "0.01",
              "enableTrading" => true,
              "feeCurrency" => "ETH",
              "market" => "ETH",
              "name" => "KCS-ETH",
              "priceIncrement" => "0.0000001",
              "quoteCurrency" => "ETH",
              "quoteIncrement" => "0.0001",
              "quoteMaxSize" => "99999999",
              "quoteMinSize" => "0.0001",
              "symbol" => "KCS-ETH"
            }
          ]
        }
      ]

      response = http_response(mocked, 200)

      with_mock_request(:get, response, fn ->
        assert {:ok, returned} = Api.all("ETH")
        assert returned == mocked
      end)
    end
  end
end
