#!/bin/bash

#run this with root

home=""
if [[ -n $1 ]]; then
        home="/home/$1"
else
        home="/home/user"
fi

read -n 1 -p "your user is located at $home"

cd $home
apt update -y
apt upgrade -y
apt install apache2 -y
apt install mariadb-server mariadb-client -y
systemctl start mariadb
#systemctl status mariad
mysql_secure_installation	#all y
apt install php -y
apt install wget -y
wget -P $home/Downloads https://wordpress.org/latest.zip
unzip $home/Downloads/latest.zip
rm $home/Downloads/latest.zip

mkdir /var/www
mkdir /var/www/html
mkdir /var/www/html/wordpress
cp -r $home/wordpress/* /var/www/html/wordpress
cd /var/www/html
rm -rf ./index.html
apt install php-mysql php-cgi php-cli php-gd -y
systemctl restart apache2
chown -R www-data:www-data /var/www
mysql -u root -p
	##create database wordpress;
	##create user "wordpress"@"%" identified by "password";
	##grant all privileges on wordpress.* to "wordpress"@"%";
	##exit
rm /var/www/html/index.php	
echo -e "<!DOCTYPE html>\n<html>\n\t<meta http-equiv=\"refresh\" content=\"0;url= wordpress/\">\n</html>" > /var/www/html/index.html
chown www-data:www-data /var/www/html/index.html

