defmodule Bst.Mixfile do
  use Mix.Project

  def project do
    [
      app: :bst,
      version: "0.1.0",
      elixir: "~> 1.11",
      test_coverage: [tool: ExCoveralls],
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:credo, "~>1.5", only: [:test, :dev]},
      {:yaml_elixir, "~> 2.7.0"},
      {:excoveralls, "~> 0.10", only: :test},
      {:sobelow, "~> 0.11", only: [:dev, :test]}
    ]
  end
end
