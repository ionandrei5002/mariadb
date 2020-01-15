# !/bin/bash

sudo service mysql start& \
# sudo service apache2 start& \
# mysql -h localhost -u root -e "CREATE DATABASE IF NOT EXISTS gmd; CREATE USER IF NOT EXISTS 'admin'@'%' IDENTIFIED BY 'admin'; GRANT ALL PRIVILEGES ON * . * TO 'admin'@'%' IDENTIFIED BY 'admin' WITH GRANT OPTION; FLUSH PRIVILEGES;"
sudo mysql -h localhost -u root -e "USE INFORMATION_SCHEMA; DROP USER 'admin'; CREATE USER 'admin'@'%' IDENTIFIED BY 'admin'; GRANT ALL PRIVILEGES ON * . * TO 'admin'@'%' IDENTIFIED BY 'admin' WITH GRANT OPTION; FLUSH PRIVILEGES;" \
sudo mysql -h localhost -u root -e "CREATE DATABASE music;" \
sudo mysql -h localhost -u root -D music < music.sql \
sudo mysql -h localhost -u root -e "CREATE DATABASE products;" \
sudo mysql -h localhost -u root -D products < latest_data.sql
/bin/bash --login