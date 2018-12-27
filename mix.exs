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
      description: "Elixir client to generate, validate and format different Brazilian docs"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    []
  end

  # Specifies which paths to compile per environment.
  # defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

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
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end
end
