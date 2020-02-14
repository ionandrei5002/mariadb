#!/bin/bash

if [ "`docker volume ls | grep mariadb_data`" == "" ]; then
    docker volume create --name mariadb1_data
fi

docker run -ti -d --rm \
	-v mariadb1_data:/var/lib/mysql/:rw \
	--name mariadb1 \
	mariadb:latest

# docker run -it --rm -p 3307:3306 -v mysql_data:/var/lib/mysql/:rw mariadb:latest
