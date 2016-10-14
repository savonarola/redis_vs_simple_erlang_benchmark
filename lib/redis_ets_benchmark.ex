defmodule RedisEtsBenchmark do

  @key_bytes 10
  @run_time 10_000
  @key "sample_key"

  @parallel [5, 10, 15, 20, 25, 30, 40, 50, 60]

  @modules [
    RedisEtsBenchmark.RedisClient,
    RedisEtsBenchmark.KvClient,
    RedisEtsBenchmark.RedisSyncClient,
    RedisEtsBenchmark.EtsClient
  ]

  def benchmark_all do
    init
    Enum.each(@modules, &benchmark_module/1)
  end

  defp init do
    :cpu_sup.start
    conf = Application.fetch_env!(:redis_ets_benchmark, :ets)
    :ets.new(conf[:name], [:set, :named_table, :public])
  end

  defp benchmark_module(client_module) do
    print_header(client_module)
    Enum.each(@parallel, fn(parallel) ->
      res = benchmark(client_module, parallel)
      print_result(res, parallel)
    end)
  end

  defp benchmark(client_module, parallel) do
    init_fn = fn -> client_module.create end
    fun = fn(client) ->
      key = @key
      client_module.set(client, key, key)
    end
    RedisEtsBenchmark.Benchmark.run(init_fn, fun, @run_time, parallel)
  end

  defp print_header(module) do
    IO.puts("Running benchmark for #{inspect module}")
    IO.puts("concurrency; total count; op/s; mean(ms); stdev %; la")
  end

  defp print_result({cnt, mean, stdev}, parallel) do
    mean_s = :io_lib.format("~.3f", [mean])
    stdev_percent = round(100 * stdev / mean)
    rps = round(1000 * cnt / @run_time)
    la_s = :io_lib.format("~.3f", [:cpu_sup.avg1 / 256])
    IO.puts "#{parallel};#{cnt};#{rps};#{mean_s};#{stdev_percent};#{la_s}"
  end

end
