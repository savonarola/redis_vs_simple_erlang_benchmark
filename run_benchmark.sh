#!/bin/bash

set -x

elixir --name bm@127.0.0.1 -S mix run -e RedisEtsBenchmark.benchmark
