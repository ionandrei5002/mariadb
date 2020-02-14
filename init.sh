# !/bin/bash

sudo sed -i 's/#bind-address/bind-address/g' /etc/mysql/mariadb.conf.d/50-server.cnf
sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

sudo service mysql start 

sudo mysql -h localhost -u root -e "CREATE DATABASE music;" 
sudo mysql -h localhost -u root -e "CREATE DATABASE products;" 
sudo mysql -h localhost -u root -e "CREATE DATABASE gmds;" 
sudo mysql -h localhost -u root -e "USE INFORMATION_SCHEMA; GRANT ALL PRIVILEGES ON * . * TO 'admin'@'%' IDENTIFIED BY 'admin' WITH GRANT OPTION; FLUSH PRIVILEGES;" 
sudo mysql -h localhost -u root -e "USE INFORMATION_SCHEMA; GRANT ALL PRIVILEGES ON * . * TO 'localuser'@'%' IDENTIFIED BY 'admin' WITH GRANT OPTION; FLUSH PRIVILEGES;" 
sudo mysql -h localhost -u root -D music < music.sql 
sudo mysql -h localhost -u root -D products < latest_data.sql

/bin/bash --login
