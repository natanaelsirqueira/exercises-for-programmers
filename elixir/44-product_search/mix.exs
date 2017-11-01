defmodule ProductSearch.Mixfile do
  use Mix.Project

  def project do
    [
      app: :product_search,
      version: "0.1.0",
      elixir: "~> 1.5",
      escript: escript(),
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def escript do
    [
      main_module: ProductSearch.CLI
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:poison, "~> 3.1"},
      {:ex_validator, "~> 0.1.0"},
      {:ex_doc, "~> 0.12"},
      {:earmark, "~> 1.0", override: true},
    ]
  end
end
