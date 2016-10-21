# Redis vs Simple Erlang benchmark

This benchmark is a comparison of `Redis` vs the simplest possible atomic `GenServer` storage  
(singlethreaded, as Redis is) as a "net shared in-memory storage".

Its purpose is to obtain a rude lower bound of productivity wich can be obtained
using `Erlang` basic primitives for constructing a simple remote storage.

`Erlang` version of storage does not use concurrent benefits of `Erlang` _purposely_
 to keep both the serializability which `Redis` offers and the simplicity of code.

Generally speaking, we compare productivity of a single CPU core fully utilized with
`Redis` storing values and with a simple spinning `GenServer` also storing values
somewhere in memory.

## Running

```
mix do deps.get, compile
./run_server.sh node_host
```

Then, on a seperate server:

```
./run_benchmark.sh
```

One should also set correct hosts in `config/config.exs` so that
benchmarking client could find servers.

## Results

The goal was to find out the extreme load of primitive commands which
can be handled by
* Redis server;
* `ets` wrapped with `GenServer` and accessed from remote via distributed Erlang.

Redis server is benchmarked with two clients: [`eredis`](https://github.com/wooga/eredis)
and [`eredis_sync`](https://github.com/funbox/eredis_sync).

The benchmarked servers (Redis and Erlang server) were run on an Amazon c4.2xlarge
instance (but obviously, in each case only one core was fully utilized).

The benchmarking client was run on a c4.4xlarge Amazon instance. The benchmarking
machine has never exhausted CPU resources during the test. The network resource
consumption also hasn't reached its limits (1Gbit).

The benchmarking client was gradually increasing load (the number of process
simultaneously making requests to server) up to the values where throughoutput
stabilized.

The results can be found in [`results`](results) folder. They are also represented
graphically below.

![Operations per second](/results/ops.png)

![Latency](/results/latency.png)

![Load Average](/results/la.png)

There is a couple of conclusions we can make.

* Since server process in each case utilizes single core, Redis is twice as productive as Erlang `GenServer` wrapped `ets`. I consider this to be a very good result for Erlang, because Redis is a specially optimized database for the cases we tested, while for Erlang we just used "standard primitives" to write a simple "database".
* For some strange reason `eredis` client has poor "backpressure": while `eredis_sync` client and Erlang
networking stopped to produce additional load when server reached its limits of throughoutput,
the load which `eredis` produces constantly increases.
