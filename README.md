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

## Sample run

These are results of a test run on my laptop.

```
>sysctl -n machdep.cpu.brand_string
Intel(R) Core(TM) i5-5257U CPU @ 2.70GHz

```


```
Benchmark suite executing with the following configuration:
warmup: 2.0s
time: 15.0s
parallel: 3
Estimated total run time: 34.0s

Benchmarking kv...
Benchmarking redis...

Name            ips        average    deviation         median
redis       6753.09      148.08 μs    (±32.94%)      149.00 μs
kv          6567.10      152.27 μs    (±34.44%)      143.00 μs

Comparison:
redis       6753.09
kv          6567.10 - 1.03x slower
```
