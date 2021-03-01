# https://wiki.alpinelinux.org/wiki/Nginx

FROM alpine:latest

MAINTAINER Henry Buisseret <hbuisser@student.s19.be>

# Install core service
RUN     apk update \
        && apk add nginx

# Creating new user and group 'www' for nginx
RUN     adduser -D -g 'www' www

# Create a directory for html files
RUN     mkdir /www \
        && mkdir -p /run/nginx \
        && chown -R www:www /var/lib/nginx \
        && chown -R www:www /www

# Backup of original nginx.conf file and remove it
RUN     cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
RUN     rm /etc/nginx/nginx.conf

# Configuring Nginx to listen to port 80 and process .html or .htm files
COPY    ./nginx.conf /etc/nginx/

# Copy html into www
COPY    ./index.html /www/

# Indiquer le port sur lequel votre application écoute
# 443 est le port https
EXPOSE 80 443

# Reload with the new config and start
#RUN     rc-service nginx start
RUN     nginx -t
CMD ["nginx", "-g", "daemon off;"]