defmodule ExPi do
  @timeout 60000

  @moduledoc """
  Documentation for `ExPi`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ExPi.hello()
      :world

  """
  def hello do
    :world
  end

  def start_sync(num) do
    Range.new(0, num)
    |> Enum.each(&call_sync/1)
  end

  def start_async(num) do
    Range.new(0, num)
    |> Enum.map(&async_call_py/1)
    |> Enum.each(&await_and_inspect/1)
  end

  def call_sync(ele) do
    with {:ok, pid} <- GenServer.start_link(ExPi.Python, []) do
      GenServer.call(pid, {:add, 1, ele})
      |> IO.inspect(label: "Sync Result")
    end
  end

  def get_and_process_candles(symbols) when is_list(symbols) do
    Enum.map(symbols, &get_and_process_candles/1)
    |> Enum.map(&process_candles/1)
    |> Enum.map(&await_and_inspect/1)
    |> IO.inspect()
  end

  def get_and_process_candles(symbol) do
    with {:ok, data} <- YahooClient.get_history(symbol) do
      data["volume"]
    end
  end

  defp process_candles(volume) do
    Task.async(fn ->
      :poolboy.transaction(
        :worker,
        fn pid ->
          GenServer.call(pid, {:avg, volume})
        end,
        @timeout
      )
    end)
  end

  defp async_call_py(ele) do
    IO.inspect(ele, label: "Calling")

    Task.async(fn ->
      :poolboy.transaction(
        :worker,
        fn pid ->
          GenServer.call(pid, {:add, 1, ele})
        end,
        @timeout
      )
    end)
  end

  defp await_and_inspect(task), do: task |> Task.await(@timeout) |> IO.inspect(label: "Finished")
end
