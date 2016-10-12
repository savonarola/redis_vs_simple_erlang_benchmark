defmodule RedisEtsBenchmark.KvClient do

  def create do
    conf = Application.fetch_env!(:redis_ets_benchmark, :kv)
    {conf[:name], conf[:node]}
  end

  def get(client, key) do
    RedisEtsBenchmark.KvServer.get(client, key)
  end

  def set(client, key, val) do
    RedisEtsBenchmark.KvServer.set(client, key, val)
  end

end
