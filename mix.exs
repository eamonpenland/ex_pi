defmodule ExPi.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_pi,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ExPi.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:erlport, "~> 0.10.1"},
      {:poolboy, "~> 1.5"},
      {:httpoison, "~> 1.7"},
      {:jason, "~> 1.2"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
