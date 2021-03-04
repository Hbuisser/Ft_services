FROM alpine

MAINTAINER Henry Buisseret <hbuisser@student.s19.be>

RUN     apk update \
        && apk add mysql \
        && apk add mariadb \
        && apk add mariadb-client \
        && apk add openrc

EXPOSE	3306