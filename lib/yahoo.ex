defmodule YahooClient do
  use HTTPoison.Base
  @base_url "https://query1.finance.yahoo.com/v8/finance/chart"

  def get_history(symbol) do
    with {:ok, %{body: body}} <- get("/#{symbol}?range=max&includePrePost=false&interval=1d") do
      body =
        body["chart"]["result"]
        |> List.first()
        |> (fn ele ->
              ele["indicators"]["quote"] |> List.first()
            end).()

      {:ok, body}
    end
  end

  def process_request_url(url) do
    (@base_url <> url)
    |> IO.inspect(label: "process_request_url", pretty: true)
  end

  def process_response_body(body) do
    Jason.decode!(body)
  end
end
