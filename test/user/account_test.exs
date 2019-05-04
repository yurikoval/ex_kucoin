defmodule ExKucoin.User.AccountTest do
  use ExUnit.Case

  import TestHelper

  alias ExKucoin.User.Account, as: Api

  describe ".all" do
    test "returns account info" do
      mocked = [
        %{
          "id" => "5bd6e9286d99522a52e458de",
          "currency" => "BTC",
          "type" => "main",
          "balance" => "237582.04299",
          "available" => "237582.032",
          "holds" => "0.01099"
        },
        %{
          "id" => "5bd6e9216d99522a52e458d6",
          "currency" => "BTC",
          "type" => "trade",
          "balance" => "1234356",
          "available" => "1234356",
          "holds" => "0"
        }
      ]

      response = http_response(mocked, 200)

      with_mock_request(:get, response, fn ->
        assert {:ok, returned} = Api.all()
        assert returned == mocked
      end)
    end
  end
end
