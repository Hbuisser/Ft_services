FROM alpine:latest

# Install core service
RUN     apk update \
        && apk update
#RUN		apk add nginx
RUN     wget nginx

# Set workdir
RUN		mkdir /tmp/ft_services_payload /www
ADD		./nginx.conf /www/tmp/ft_services_payload
ADD     ./init.sh /www/tmp/ft_services_payload
WORKDIR	/tmp/ft_services_payload
RUN     chmod +x init.sh

# Moving necessary files
ADD		nginx.conf /etc/nginx/
#ADD		sshd_config /etc/ssh/
ADD		index.html /www

EXPOSE	80 443 22

CMD ["/bin/sh", "/tmp/ft_services_payload/init.sh"]