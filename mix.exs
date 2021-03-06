defmodule AdventOfCode.Mixfile do
  use Mix.Project

  def project do
    [
      app: :advent_of_code,
      version: "2021.1.7",
      elixir: "~> 1.5",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :eex]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      {:libgraph, "~> 0.13"},
      {:advent_of_code_helper, "~> 0.2.0"}
    ]
  end
end
