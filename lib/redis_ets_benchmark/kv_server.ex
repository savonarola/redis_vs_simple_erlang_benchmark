defmodule RedisEtsBenchmark.KvServer do

  use GenServer

  def start_link do
    name = Application.fetch_env!(:redis_ets_benchmark, :kv)[:name]
    GenServer.start_link(__MODULE__, [], [name: name])
  end

  def init([]) do
    {:ok, :ets.new(__MODULE__, [:set])}
  end

  def get(server, key) do
    GenServer.call(server, {:get, key})
  end

  def set(server, key, value) do
    GenServer.call(server, {:set, key, value})
  end

  def handle_call({:get, key}, _from, ets) do
    case :ets.lookup(ets, key) do
      [] -> {:error, :not_found}
      [{^key, value} | _] -> {:ok, value}
    end
  end

  def handle_call({:set, key, value}, _from, ets) do
    :ets.insert(ets, {key, value})
    {:reply, :ok, ets}
  end

end
