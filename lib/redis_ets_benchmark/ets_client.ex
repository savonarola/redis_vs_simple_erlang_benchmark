defmodule RedisEtsBenchmark.EtsClient do

  def create do
    conf = Application.fetch_env!(:redis_ets_benchmark, :ets)
    conf[:name]
  end

  def get(name, key) do
    case :ets.lookup(name, key) do
      [] -> {:error, :not_found}
      [{^key, value} | _] -> {:ok, value}
    end
  end

  def set(name, key, val) do
    :ets.insert(name, {key, val})
  end

end
