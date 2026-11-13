#!/bin/bash

set -euo pipefail

suffix=$(date +%s)
project=hse_counter_$suffix

project_down() {
    docker compose -p $project down -v
}

trap project_down EXIT

echo Testing with project $project

docker compose -p $project up --build --force-recreate -d --wait --wait-timeout 60

count=$(timeout 2s curl -fsS http://localhost:8081 | grep -o '"count": [0-9][0-9]*' | grep -o '[0-9][0-9]*')

if [ "$count" -ne 0 ]; then
    echo "X | SOURCE COUNT IS NOT ZERO"
    exit 1
else
    echo "V | SOURCE COUNT IS ZERO"
fi

N=5

for i in $(seq 1 $N); do
    timeout 2s curl -fsS -X POST http://localhost:8081/increment > /dev/null
done

count=$(timeout 2s curl -fsS http://localhost:8081 | grep -o '"count": [0-9][0-9]*' | grep -o '[0-9][0-9]*')

if [ "$count" -ne "$N" ]; then
    echo "X | MODIFIED COUNT IS NOT $N"
    exit 1
else
    echo "V | MODIFIED COUNT IS $N"
fi

echo "Recreating app..."
docker compose -p $project up --force-recreate -d --wait --wait-timeout 60 app

count=$(timeout 2s curl -fsS http://localhost:8081 | grep -o '"count": [0-9][0-9]*' | grep -o '[0-9][0-9]*')

if [ "$count" -ne "$N" ]; then
    echo "X | COUNT AFTER RECREATE IS $count, NOT $N"
    exit 1
else
    echo "V | COUNT AFTER RECREATE IS $N"
fi

echo "Stopping redis..."
docker compose -p $project stop redis

code=$(timeout 2s curl -fsS http://localhost:8081/healthz -w "%{http_code}" -o /dev/null)

if [ "$code" -ne 200 ]; then
    echo "X | /healthz response code without redis is $code, not 200"
    exit 1
else
    echo "V | /healthz response code without redis is 200"
fi

code=$(timeout 2s curl -sS http://localhost:8081/readyz -w "%{http_code}" -o /dev/null)

if [ "$code" -ne 503 ]; then
    echo "X | /readyz response code without redis is $code, not 503"
    exit 1
else
    echo "V | /readyz response code without redis is 503"
fi

code=$(timeout 2s curl -sS -X POST http://localhost:8081/increment -w "%{http_code}" -o /dev/null)

if [ "$code" -ne 503 ]; then
    echo "X | /increment response code without redis is $code, not 503"
    exit 1
else
    echo "V | /increment response code without redis is 503"
fi

echo "Starting redis..."
docker compose -p $project up --wait --wait-timeout 60 redis

count=$(timeout 2s curl -fsS http://localhost:8081 | grep -o '"count": [0-9][0-9]*' | grep -o '[0-9][0-9]*')

echo "Stopping application..."
docker compose -p $project down

volume_name="${project}_hse_redis"

# 10.11.2026, amd64
docker run --rm \
  -v $volume_name:/source \
  -v ./tmp:/dest \
  busybox:1.38-glibc@sha256:99813cb178ace2cd9c6c53ee3bddef5d2f5708aa438335111d7a9e3c5e1aaebe \
  tar -czp -C /source -f /dest/${suffix}.tar.gz .

echo "V | EVERYTHING OK :-) )))"
