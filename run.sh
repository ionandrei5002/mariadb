#!/bin/bash

#!/bin/bash

if [ "`docker volume ls | grep mariadb_data`" == "" ]; then
    docker volume create --name mariadb_data
fi

docker run -ti --rm \
	-v mariadb_data:/var/lib/mysql/:rw \
	--name mariadb \
	mariadb:latest

# docker run -it --rm -p 3307:3306 -v mysql_data:/var/lib/mysql/:rw mariadb:latest
