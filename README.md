# 21ft_server 
This topic is intended to introduce you to system administration. It will make you aware
of the importance of using scripts to automate your tasks. For that, you will discover
the docker technology and use it to install a complete web server. This server will run
multiples services: Wordpress, phpMyAdmin, and a SQL database.

CMD build:
$> docker build -t name .

CMD run:
$> docker run --name aname -it -p 80:80 -p 443:443 name