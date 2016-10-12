defmodule RedisEtsBenchmark do

  @key_bytes 10
  @run_time 15
  @parallel 3

  def benchmark do
    Benchee.run(%{time: @run_time, parallel: @parallel}, %{
      "redis" => benchmark_fn(RedisEtsBenchmark.RedisClient),
      "kv" => benchmark_fn(RedisEtsBenchmark.KvClient)
    })
  end

  def benchmark_fn(client_module) do
    client = client_module.create
    fn ->
      key = @key_bytes |> :crypto.strong_rand_bytes() |> :base64.encode()
      client_module.set(client, key, key)
    end
  end

end
