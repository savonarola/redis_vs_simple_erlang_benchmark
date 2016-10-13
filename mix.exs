defmodule RedisEtsBenchmark.Mixfile do
  use Mix.Project

  def project do
    [app: :redis_ets_benchmark,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger, :eredis]]
  end

  defp deps do
    [
      {:eredis_sync, git: "https://github.com/funbox/eredis_sync.git", tag: "v0.1.0"}
    ]
  end
end
