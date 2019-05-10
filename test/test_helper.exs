ExUnit.start()

defmodule TestHelper do
  use ExUnit.Case, async: false

  import Mock

  def with_mock_request(:get, response, fun) do
    with_mock_request({:get, fn _url, _headers, _opts -> response end}, fun)
  end

  def with_mock_request(:post, response, fun) do
    with_mock_request({:post, fn _url, _body, _headers, _opts -> response end}, fun)
  end

  def with_mock_request(:delete, response, fun) do
    with_mock_request({:delete, fn _url, _headers, _opts -> response end}, fun)
  end

  def with_mock_request(stub, fun) do
    with_mock HTTPoison, [:passthrough], [stub] do
      fun.()
    end
  end

  def http_response(map, status_code) do
    {:ok, json} = Jason.encode(map)
    {:ok, %HTTPoison.Response{body: json, status_code: status_code}}
  end

  def filter_sensitive_data do
    ExVCR.Config.filter_request_headers("KC-API-KEY")
    ExVCR.Config.filter_request_headers("KC-API-SIGN")
    ExVCR.Config.filter_request_headers("KC-API-PASSPHRASE")
  end
end
