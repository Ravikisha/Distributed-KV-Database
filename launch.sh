#!/bin/bash
set -e

trap 'killall distributedKV' SIGINT

cd $(dirname $0)

killall distributedKV || true
sleep 0.1

go install -v

distributedKV -db-location=Mumbai.db -http-addr=127.0.0.2:8080 -config-file=sharding.toml -shard=Mumbai &
distributedKV -db-location=Mumbai-r.db -http-addr=127.0.0.22:8080 -config-file=sharding.toml -shard=Mumbai -replica &

distributedKV -db-location=Delhi.db -http-addr=127.0.0.3:8080 -config-file=sharding.toml -shard=Delhi &
distributedKV -db-location=Delhi-r.db -http-addr=127.0.0.33:8080 -config-file=sharding.toml -shard=Delhi -replica &

distributedKV -db-location=Chennai.db -http-addr=127.0.0.4:8080 -config-file=sharding.toml -shard=Chennai &
distributedKV -db-location=Chennai-r.db -http-addr=127.0.0.44:8080 -config-file=sharding.toml -shard=Chennai -replica &

distributedKV -db-location=Bangalore.db -http-addr=127.0.0.5:8080 -config-file=sharding.toml -shard=Bangalore &
distributedKV -db-location=Bangalore-r.db -http-addr=127.0.0.55:8080 -config-file=sharding.toml -shard=Bangalore -replica &

wait
