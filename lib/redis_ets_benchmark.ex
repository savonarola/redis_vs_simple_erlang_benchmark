defmodule RedisEtsBenchmark do

  @key_bytes 10
  @run_time 30
  @parallel 1
  @key "sample_key"

  def benchmark do
    Benchee.run(%{time: @run_time, parallel: @parallel}, %{
      "eredis" => benchmark_fn(RedisEtsBenchmark.RedisClient),
      "kv" => benchmark_fn(RedisEtsBenchmark.KvClient),
      "eredis_sync" => benchmark_fn(RedisEtsBenchmark.RedisSyncClient)
    })
  end

  def benchmark_fn(client_module) do
    client = client_module.create
    fn ->
      key = @sample_key
      client_module.set(client, key, key)
    end
  end

end
