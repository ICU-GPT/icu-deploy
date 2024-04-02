#!/bin/bash

set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
source $DIR/common.sh

set +o noglob
item=0
# flag to using docker compose v1 or v2, default would using v1 docker-compose
DOCKER_COMPOSE=docker-compose

workdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $workdir

h2 "[Step $item]: checking if docker is installed ..."; let item+=1
check_docker

h2 "[Step $item]: checking docker-compose is installed ..."; let item+=1
check_dockercompose

if [ -n "$DOCKER_COMPOSE ps -q"  ]
    then
        note "stopping existing ICU database instance ..." 
        $DOCKER_COMPOSE down -v
fi
echo ""

h2 "[Step $item]: starting ICU databases ..."
$DOCKER_COMPOSE up -d

success $"----ICU database has been installed and started successfully.----"