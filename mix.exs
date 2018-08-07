defmodule GoogleRoads.MixProject do
  use Mix.Project

  @version File.read!("VERSION") |> String.trim

  def project do
    [
      app: :google_roads,
      description: "Google Roads API in Elixir",
      version: @version,
      elixir: "~> 1.7",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),

      # Docs
      name: "GoogleRoads",
      source_url: "https://github.com/kmonline/ex_roads",
      homepage_url: "https://hex.pm/packages/google_roads/",
      docs: docs()
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
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      {:ex_doc, "~> 0.19.1", only: :dev},
      {:ex_guard, "~> 1.3", only: :dev}
    ]
  end

  defp package do
    [
      files: ~w(lib mix.exs README* LICENSE* VERSION),
      maintainers: ["Weverton Timoteo", "Leandro Heuert"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/kmonline/ex_roads"}
    ]
  end

  defp docs do
    [
      main: "GoogleRoads",
      extras: ~w(README* LICENSE*)
    ]
  end
end
