defmodule ExPi.Python do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, [])
  end


  def init(_) do
    path = [
      :code.priv_dir(:ex_pi),
      "python"
    ]|> Path.join()

    {:ok, python_pid} = :python.start([
      {:python, 'python3'},
      {:python_path, to_charlist(path)},
    ])
    IO.puts("*** started python -- pid: #{inspect(python_pid)}")
    state = [pid: python_pid]
    {:ok, state}
  end

  def handle_call({:add, num1, num2}, _from, state) do
    python_pid = state[:pid]
    result = :python.call(python_pid, :main, :add, [num1, num2])
    {:reply, {:result, result}, state}
  end

  def terminate(_reason, state) do
    python_pid = state[:pid]
    :python.stop(python_pid)
    IO.puts("*** terminated")
  end
end
