defmodule Weather.MixProject do
  use Mix.Project

  def project do
    [
      app: :weather,
      version: "0.1.0",
      elixir: "~> 1.7",
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Weather.Application, []}
    ]
  end

  defp deps do
    [
      {:cowboy, "~> 2.9"},
      {:esbuild, "~> 0.7"},
      {:httpoison, "~> 2.0"},
      {:jason, "~> 1.2"},
      {:tailwind, "~> 0.2"}
    ]
  end
end
