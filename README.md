# RedisEtsBenchmark

Very primitive comparison of `Redis` vs `GenServer` + `ets` + distributed Erlang
as a "net shared in-memory storage".

## Running

```
mix do deps.get, compile
./run_server.sh
```

Then, in seperate terminal:

```
./run_benchmark.sh
```

## Sample run

These are results of a test run on my laptop.

```
>sysctl -n machdep.cpu.brand_string
Intel(R) Core(TM) i5-5257U CPU @ 2.70GHz

```


```
time: 30.0s
parallel: 1
Estimated total run time: 96.0s

Benchmarking eredis...
Benchmarking eredis_sync...
Benchmarking kv...

Name                  ips        average    deviation         median
eredis_sync      17538.06       57.02 μs    (±58.04%)       50.00 μs
eredis           15472.90       64.63 μs    (±39.44%)       57.00 μs
kv               11730.16       85.25 μs    (±42.88%)       70.00 μs

Comparison:
eredis_sync      17538.06
eredis           15472.90 - 1.13x slower
kv               11730.16 - 1.50x slower
```
