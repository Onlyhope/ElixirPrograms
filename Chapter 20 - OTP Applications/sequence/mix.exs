defmodule Sequence.MixProject do
  use Mix.Project

  def project do
    [
      app: :sequence,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Sequence.Application, []},
      registered: [Sequence.Server],
      env: [
        initial_number: 456,
      ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    # runtime: false tells mix to not start Distillery with the running application# runtime: false tells mix to not start Distillery with the running application
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:distillery, "~> 2.0.12", runtime: false}
    ]
  end
end
