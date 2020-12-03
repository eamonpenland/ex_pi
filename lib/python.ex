defmodule ExPi.Python do
  def call_python do
    path = [
      :code.priv_dir(:ex_pi),
      "python"
    ]|> Path.join()

    {:ok, python_pid} = :python.start([
      {:python, 'python3'},
      {:python_path, to_charlist(path)},
    ])

    :python.call(python_pid, :main, :add, [])
  end
end
