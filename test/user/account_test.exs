defmodule ExKucoin.User.AccountTest do
  import TestHelper
  use ExUnit.Case, async: false

  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ExKucoin.User.Account, as: Api

  setup_all do
    config = %ExKucoin.Config{
      api_key: System.get_env("API_KEY") || "XXX",
      api_secret: System.get_env("API_SECRET") || "XXX",
      api_passphrase: System.get_env("API_PASSPHRASE") || "XXX",
      api_url: "https://openapi-sandbox.kucoin.com"
    }

    %{config: config}
  end

  describe ".all" do
    test "returns account info", %{config: config} do
      filter_sensitive_data()

      use_cassette "user/account_all" do
        assert {:ok, returned} = Api.all(%{}, config)

        assert %{
                 "data" => [
                   %{
                     "available" => "1",
                     "balance" => "1",
                     "currency" => "BTC",
                     "holds" => "0",
                     "id" => "5ccd0f52ef83c74b737140bf",
                     "type" => "main"
                   },
                   %{
                     "available" => "1000",
                     "balance" => "1000",
                     "currency" => "KCS",
                     "holds" => "0",
                     "id" => "5ccd0f52ef83c74b737140c7",
                     "type" => "main"
                   },
                   %{
                     "available" => "10",
                     "balance" => "10",
                     "currency" => "ETH",
                     "holds" => "0",
                     "id" => "5ccd0f52ef83c74b737140c5",
                     "type" => "main"
                   }
                 ]
               } = returned
      end
    end
  end
end
