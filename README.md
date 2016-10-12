# RedisEtsBenchmark

Very primitive comparison of `Redis` vs `GenServer` + `ets` + distributed Erlang
as a "distributed in-memory storage".

## Running

```
mix do deps.get, compile
./run_server.sh
```

Then, in seperate terminal:

```
./run_benchmark.sh
```
