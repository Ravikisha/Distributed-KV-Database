#!/bin/bash
set -e

trap 'killall distributedKV' SIGINT

cd $(dirname $0)

killall distributedKV || true
sleep 0.1

go install -v

distributedKV -db-location=moscow.db -http-addr=127.0.0.2:8080 -config-file=sharding.toml -shard=Moscow &
distributedKV -db-location=moscow-r.db -http-addr=127.0.0.22:8080 -config-file=sharding.toml -shard=Moscow -replica &

distributedKV -db-location=minsk.db -http-addr=127.0.0.3:8080 -config-file=sharding.toml -shard=Minsk &
distributedKV -db-location=minsk-r.db -http-addr=127.0.0.33:8080 -config-file=sharding.toml -shard=Minsk -replica &

distributedKV -db-location=kiev.db -http-addr=127.0.0.4:8080 -config-file=sharding.toml -shard=Kiev &
distributedKV -db-location=kiev-r.db -http-addr=127.0.0.44:8080 -config-file=sharding.toml -shard=Kiev -replica &

distributedKV -db-location=tashkent.db -http-addr=127.0.0.5:8080 -config-file=sharding.toml -shard=Tashkent &
distributedKV -db-location=tashkent-r.db -http-addr=127.0.0.55:8080 -config-file=sharding.toml -shard=Tashkent -replica &

wait
