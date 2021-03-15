FROM alpine:3.12

MAINTAINER Henry Buisseret <hbuisser@student.s19.be>

RUN apk update && apk add wget && mkdir /www \
&& apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session

RUN apk add nginx

RUN wget https://wordpress.org/latest.tar.gz \
&& tar -xvf latest.tar.gz \
&& mv wordpress/* /www \
&& rm -rf /var/cache/apk/*

# We copy wordpress database config file
COPY wp-config.php /www/wp-config.php

# add nginx
#Creation of user linked with nginx.conf, -D means default
RUN adduser -D www; 
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /wordpress
COPY nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /run/nginx #Last command is demanded by "nginx -t" config file test, to create nginx.pid file
RUN nginx -t

# RUN  chown -R www-data:www-data /var/www/
EXPOSE 5050

CMD ["nginx", "-g", "daemon off;"]