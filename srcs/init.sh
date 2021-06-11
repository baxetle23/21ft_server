service mysql start

#Config
chown -R www-data /var/www/*
chmod -R 755 /var/www/*

#SSL
mkdir /etc/nginx/ssl
openssl req -x509 -nodes -days 365 -subj "/C=LR/ST=middle-earth/L=gondor/O=the_fellowship_of_the_ring/OU=21_school/CN=lcash" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;

#Nginx
mv ./tmp/nginx-conf /etc/nginx/sites-available/localhost
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost
rm -rf /etc/nginx/sites-enabled/default
rm -rf /etc/nginx/sites-available/default

#MySQL
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "update mysql.user set plugin='' where user='root';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

#Phpmyadmin
mkdir /var/www/html/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz --strip-components 1 -C /var/www/html/phpmyadmin
mv ./tmp/phpmyadmin.inc.php /var/www/html/phpmyadmin/config.inc.php
rm -rf phpMyAdmin-4.9.0.1-all-languages.tar.gz

#Wordpress
mkdir /var/www/html/wordpress
wget -c https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
mv wordpress/ /var/www/html
mv /tmp/wp-config.php /var/www/html/wordpress
rm -rf latest.tar.gz

service php7.3-fpm start
service nginx start

bash