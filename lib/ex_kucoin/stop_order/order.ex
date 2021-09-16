defmodule ExKucoin.StopOrder.Order do
  @moduledoc """
  Handles stop orders
  """

  import ExKucoin.Api.Private

  @prefix "/api/v1/stop-order"

  @doc """
  Request via this endpoint to get your current order list

  [API Docs](https://docs.kucoin.com/#list-orders)
  """
  def list(params \\ %{}, config \\ nil) do
    get("#{@prefix}", params, config)
  end
end
