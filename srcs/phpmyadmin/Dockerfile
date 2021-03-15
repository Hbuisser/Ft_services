FROM alpine

MAINTAINER Henry Buisseret <hbuisser@student.s19.be>

RUN		apk add wget php7 php7-fpm php7-opcache php7-gd 
RUN     apk add php7-mysqli php7-zlib php7-curl php7-mbstring 
RUN     apk add php7-json php7-session nginx

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-all-languages.tar.gz 
RUN	tar -zxzf phpMyAdmin-5.0.1-all-languages.tar.gz 
RUN mv phpMyAdmin-5.0.1-all-languages /var/www/html/phpMyAdmin 
RUN rm phpMyAdmin-5.0.1-all-languages.tar.gz \
RUN mkdir /var/www/html/phpMyAdmin/tmp \
RUN chmod 777 /var/www/html/phpMyAdmin/tmp

ADD /srcs/nginx.conf /etc/nginx/sites-available/
ADD /srcs/nginx.conf /etc/nginx/sites-enabled/

ADD /srcs/config.inc.php /var/www/html/phpMyAdmin

EXPOSE 5000

CMD /bin/bash ./srcs/phpmyadmin_config.sh





