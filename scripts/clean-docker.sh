#!/bin/sh

old_containers_filter=${1:-'weeks ago'}

docker ps --filter "status=exited" | grep $old_containers_filter | awk '{print $1}' | xargs --no-run-if-empty docker rm
docker images | grep $old_containers_filter | awk '{print $3}' | xargs --no-run-if-empty docker rmi
docker image prune
docker rmi $(docker images -f "dangling=true" -q)  
docker volume prune
