FROM alpine:3.12

MAINTAINER Henry Buisseret <hbuisser@student.s19.be>

RUN apk update && apk add openrc && apk add openssl && apk add wget && apk add nginx && apk add php7 php7-fpm php7-iconv php7-json php7-mbstring php7-mysqli php7-phar php7-session

#Get phpMyAdmin folder
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN mv phpMyAdmin-4.9.0.1-all-languages phpmyadmin
RUN rm phpMyAdmin-4.9.0.1-all-languages.tar.gz

#Set phpmyadmin and its config
COPY /srcs/config.inc.php phpmyadmin/config.inc.php

# config nginx
RUN adduser -D www; #Creation of user linked with nginx.conf, -D means default
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /phpmyadmin
COPY /srcs/nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /run/nginx 
#Last command is demanded by "nginx -t" config file test, to create nginx.pid file
RUN nginx -t

EXPOSE 5000

CMD ["nginx", "-g", "daemon off;"]




