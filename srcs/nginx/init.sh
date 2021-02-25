#! /bin/sh

#echo "root:hbuisser@" | chpasswd

#Creating new user and group 'www' for nginx
adduser -D -g 'www' www

#Create a directory for html files
chown -R www:www /var/lib/nginx
chown -R www:www /www


mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig

rc-service nginx start
nginx -t

#nginx -g 'pid /tmp/nginx.pid; daemon off;'