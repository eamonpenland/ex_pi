defmodule ExPi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      :poolboy.child_spec(:worker, poolboy_config())
      # Starts a worker by calling: ExPi.Worker.start_link(arg)
      # {ExPi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExPi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp poolboy_config do
    [
      {:name, {:local, :worker}},
      {:worker_module, ExPi.Python},
      {:size, 5},
      {:max_overflow, 0}
    ]
  end
end
