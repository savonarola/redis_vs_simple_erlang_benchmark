defmodule RedisEtsBenchmark.RedisSyncClient do

  def create do
    conf = Application.fetch_env!(:redis_ets_benchmark, :eredis_sync)
    {:ok, pid} = :eredis_sync.connect(conf[:host], conf[:port], conf[:db])
    pid
  end

  def get(client, key) do
    {:ok, val} = :eredis_sync.q(client, ["GET", key])
    val
  end

  def set(client, key, val) do
    {:ok, _} = :eredis_sync.q(client, ["SET", key, val])
    :ok
  end

end
