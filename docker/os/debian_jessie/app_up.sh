#!/bin/bash

# Brings up cyber-dojo after running bootstrap.sh
# which puts both .yml files into the same folder.
# Port 80 must be open.

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

pushd ${DIR} > /dev/null

docker-compose \
  --file docker-compose.yml \
  --file docker-compose.debian_jessie.yml \
  up &

popd > /dev/null
