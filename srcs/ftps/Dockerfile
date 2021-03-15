#https://www.pureftpd.org/project/pure-ftpd/
#https://download.pureftpd.org/pub/pure-ftpd/doc/README

FROM alpine:3.12

MAINTAINER Henry Buisseret <hbuisser@student.s19.be>

RUN apk update && apk add openssl && apk add pure-ftpd --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

#ssl
RUN mkdir -p /etc/ssl/private
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/pure-ftpd.pem -out /etc/ssl/private/pure-ftpd.pem -subj "/C=BE/ST=BRUSSELS/L=BRUSSELS/O=19school"

#create user
RUN adduser -D hbuisser
#The chpasswd command reads a list of user name and password pairs from standard input and uses this information to update a group of existing users
RUN echo "hbuisser:pass123" | chpasswd 

#Port 21 is for the ftps platform and is the default ftp port
#All the other ports are for passive-mode downloads on ftps
EXPOSE 21 30000 30001 30002 30004

#-Y 2 -> Refuse non-ssl connections -> TLS connection should be established to be secure
#-p for minport:maxport
#-P for IP address
CMD /usr/sbin/pure-ftpd -Y 2 -p 30000:30004 -P 192.168.99.133
