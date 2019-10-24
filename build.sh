#!/bin/bash

userid=$(id -u)
groupid=$(id -g)
username=$(whoami)

docker build \
    --build-arg userid="$userid" \
    --build-arg groupid="$groupid" \
    --build-arg username="$username" \
    --rm \
    -t mariadb:latest .

docker system prune -f