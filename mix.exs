defmodule App.MixProject do
  use Mix.Project

  @version "0.2.0"

  def project do
    [
      app: :brdocs,
      version: @version,
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: prefered_cli_env(),
      deps: deps(),
      package: package(),
      description: "Elixir client to generate, validate and format different Brazilian docs",

      # docs
      source_url: "https://github.com/emaiax/brdocs",
      homepage_url: "https://github.com/emaiax/brdocs",
      docs: [extras: ["README.md"]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    []
  end

  # Specifies which paths to compile per environment.
  # defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp prefered_cli_env do
    [
      coveralls: :test,
      "coveralls.post": :test,
      "coveralls.html": :test,
      "coveralls.detail": :test
    ]
  end

  def package do
    [
      files: ~w(lib test config mix.exs README*),
      maintainers: ["Eduardo Maia"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/emaiax/brdocs"}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.25.1", only: :dev},
      {:excoveralls, "~> 0.10", only: :test},
      {:credo, "~> 0.10.0", only: [:dev, :test]},
      {:dialyxir, "~> 1.1.0", only: [:dev], runtime: false},

      # optional
      {:ecto, "~> 2.2 or ~> 3.0", optional: true}
    ]
  end
end
