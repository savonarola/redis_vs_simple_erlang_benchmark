#!/bin/bash

set -x

elixir --erl "+K true" --name bm@127.0.0.1 -S mix run -e RedisEtsBenchmark.benchmark_all
