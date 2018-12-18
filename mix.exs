defmodule App.MixProject do
  use Mix.Project

  def project do
    [
      app: :brdocs,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      preferred_cli_env: ["test.watch": :test],
      description: "Validation and formatting for brazilian ID documents (CPF/CNPJ)"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Specifies which paths to compile per environment.
  # defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  def package do
    [
      files: ~w(lib test config mix.exs README*),
      maintainers: ["Eduardo Maia"],
      licenses: ["Unlicense"],
      links: %{"GitHub" => "https://github.com/emaiax/brdocs"}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    []
  end
end
