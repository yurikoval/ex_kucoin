defmodule ExKucoin.Trade.Order do
  @moduledoc """
  Handles orders
  """

  import ExKucoin.Api.Private

  @prefix "/api/v1"

  @doc """
  Place a new order

  [API Docs](https://docs.kucoin.com/#place-a-new-order)
  """
  def create(params, config \\ nil) do
    post("#{@prefix}/orders", params, config)
  end

  @doc """
  Request via this endpoint to get your current order list

  [API Docs](https://docs.kucoin.com/#list-orders)
  """
  def list(params, config \\ nil) do
    get("#{@prefix}/orders", params, config)
  end
end
