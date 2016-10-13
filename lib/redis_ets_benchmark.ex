defmodule RedisEtsBenchmark do

  @key_bytes 10
  @run_time 10_000
  @parallel 5
  @key "sample_key"

  @modules [
    RedisEtsBenchmark.RedisClient,
    RedisEtsBenchmark.KvClient,
    RedisEtsBenchmark.RedisSyncClient
  ]

  def benchmark_all do
    Enum.each(@modules, &benchmark_module/1)
  end

  defp benchmark_module(client_module) do
    client_module
    |> print_header
    |> benchmark
    |> print_result
  end

  defp benchmark(client_module) do
    init_fn = fn -> client_module.create end
    fun = fn(client) ->
      key = @key
      client_module.set(client, key, key)
    end
    RedisEtsBenchmark.Benchmark.run(init_fn, fun, @run_time, @parallel)
  end

  defp print_header(module) do
    IO.puts("Running benchmark for #{inspect module}")
    module
  end

  defp print_result({cnt, mean, stdev}) do
    mean_s = :io_lib.format("~.3f", [mean])
    stdev_percent = round(100 * stdev / mean)
    rps = round(1000 * cnt / @run_time)
    IO.puts "Count: #{cnt}(#{rps} op/s), mean: #{mean_s}ms, mean  stdev: #{stdev_percent}%"
  end

end
