defmodule ExKucoin.Trade.OrderTest do
  import TestHelper
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  alias ExKucoin.Trade.Order, as: Api

  setup_all do
    config = %ExKucoin.Config{
      api_key: System.get_env("API_KEY") || "XXX",
      api_secret: System.get_env("API_SECRET") || "XXX",
      api_passphrase: System.get_env("API_PASSPHRASE") || "XXX",
      api_url: "https://openapi-sandbox.kucoin.com"
    }

    %{config: config}
  end

  describe ".create" do
    test "creates market sell order", %{config: config} do
      params = %{
        "clientOid" => "XXXXX",
        "side" => "sell",
        "symbol" => "KCS-BTC",
        "type" => "market",
        "size" => 1
      }

      filter_sensitive_data()

      use_cassette "trade/create_sell_order" do
        assert {:ok, detail} = Api.create(params, config)

        assert %{
                 "code" => "200000",
                 "data" => %{"orderId" => _order_id}
               } = detail
      end
    end

    test "creates market buy order", %{config: config} do
      params = %{
        "clientOid" => "XXXXX3",
        "side" => "buy",
        "symbol" => "KCS-BTC",
        "type" => "market",
        "size" => 1
      }

      filter_sensitive_data()

      use_cassette "trade/create_buy_order" do
        assert {:ok, detail} = Api.create(params, config)

        assert %{
                 "code" => "200000",
                 "data" => %{"orderId" => _order_id}
               } = detail
      end
    end
  end
end
