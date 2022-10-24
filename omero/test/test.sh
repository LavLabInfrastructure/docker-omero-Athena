#!/bin/sh
set -eu

rm -f certs/*

docker-compose -f docker-compose.icessl.yml -f docker-compose.test.yml -f docker-compose.yml build
docker-compose -f docker-compose.icessl.yml -f docker-compose.yml run icessl
docker-compose up -d
./wait_for_login.sh
docker-compose -f docker-compose.test.yml -f docker-compose.yml run test
