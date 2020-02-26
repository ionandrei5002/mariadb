# !/bin/bash

sudo service mysql start 

sudo mysql -h localhost -u root -e "CREATE DATABASE appannie;"
sudo mysql -h localhost -u root -D appannie < appannie.sql
sudo mysql -h localhost -u root -e "USE INFORMATION_SCHEMA; GRANT ALL PRIVILEGES ON * . * TO 'admin'@'%' IDENTIFIED BY 'admin' WITH GRANT OPTION; FLUSH PRIVILEGES;" 

/bin/bash --login