defmodule ExKucoin.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_kucoin,
      version: "0.0.4",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      package: package(),
      name: "ExKucoin",
      description: "KuCoin API client for Elixir",
      source_url: "https://github.com/yurikoval/ex_kucoin"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.3.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.6", only: :dev, runtime: false},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:exvcr, "~> 0.10", only: [:dev, :test]},
      {:httpoison, "~> 1.0"},
      {:jason, "~> 1.1"},
      {:mix_test_watch, "~> 1.0", only: :dev, runtime: false},
      {:mock, "~> 0.3.3", only: :test},
      {:websockex, "~> 0.4.0"}
    ]
  end

  defp docs do
    [
      main: "ExKucoin",
      extras: ["README.md"]
    ]
  end

  defp package do
    [
      name: :ex_kucoin,
      maintainers: ["Yuri Koval'ov"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/yurikoval/ex_kucoin"}
    ]
  end
end
