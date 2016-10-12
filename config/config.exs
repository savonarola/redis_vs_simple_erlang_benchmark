use Mix.Config

config :redis_ets_benchmark, :redis,
  host: '127.0.0.1',
  port: 6379,
  db: 1

config :redis_ets_benchmark, :kv,
  name: :kvs,
  node: :"kvs_bm@127.0.0.1"
