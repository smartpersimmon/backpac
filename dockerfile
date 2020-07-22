FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y install apache2 software-properties-common

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php

RUN apt-get update && apt-get install -y libapache2-mod-php7.3 php7.3 php7.3-cli php7.3-mysql 

RUN a2enmod rewrite

EXPOSE 80

CMD apachectl -D FOREGROUND
