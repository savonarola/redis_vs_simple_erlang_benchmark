#!/bin/bash

set -x

elixir --name kvs_bm@127.0.0.1 -S mix run -e RedisEtsBenchmark.KvServer.start_link --no-halt
