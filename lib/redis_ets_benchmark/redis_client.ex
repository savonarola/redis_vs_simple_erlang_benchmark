defmodule RedisEtsBenchmark.RedisClient do

  def create do
    conf = Application.fetch_env!(:redis_ets_benchmark, :redis)
    IO.inspect conf
    IO.inspect([conf[:host], conf[:port], conf[:db]])
    {:ok, pid} = :eredis.start_link(conf[:host], conf[:port], conf[:db])
    pid
  end

  def get(client, key) do
    {:ok, val} = :eredis.q(client, ["GET", key])
    val
  end

  def set(client, key, val) do
    {:ok, _} = :eredis.q(client, ["SET", key, val])
    :ok
  end

end
