#!/bin/bash

sudo service mysql start& \
sudo service apache2 start& \
/bin/bash \
# mysql -h localhost -u root -e "CREATE DATABASE IF NOT EXISTS gmd; CREATE USER IF NOT EXISTS 'admin'@'%' IDENTIFIED BY 'admin'; GRANT ALL PRIVILEGES ON * . * TO 'admin'@'%' IDENTIFIED BY 'admin' WITH GRANT OPTION; FLUSH PRIVILEGES;"
sudo mysql -h localhost -u root -e "USE INFORMATION_SCHEMA; CREATE USER 'admin'@'%' IDENTIFIED BY 'admin'; GRANT ALL PRIVILEGES ON * . * TO 'admin'@'%' IDENTIFIED BY 'admin' WITH GRANT OPTION; FLUSH PRIVILEGES;"
sudo mysql -h localhost -u root -e "CREATE DATABASE `music`;"
sudo mysql -h localhost -u root -D music < music.sql
