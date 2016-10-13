use Mix.Config

config :redis_ets_benchmark, :eredis,
  host: '172.31.12.223',
  port: 6379,
  db: 1

config :redis_ets_benchmark, :eredis_sync,
  host: {172,31,12,223},
  port: 6379,
  db: 1


config :redis_ets_benchmark, :kv,
  name: :kvs,
  node: :"kvs_bm@172.31.12.223"
