defmodule ExKucoin.User.Account do
  import ExKucoin.Api.Private

  @prefix "/api/v1"

  @moduledoc """
  User's Accounts client.
  """

  @doc """
  Get a list of accounts.

  Refer to params listed in [API docs](https://docs.kucoin.com/#list-accounts)

  ## Examples

      iex> ExKucoin.User.Account.all()
      {:ok, [%{
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
      }]}

  """
  def all do
    get("#{@prefix}/accounts")
  end
end
