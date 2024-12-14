FROM php:8.0-apache
MAINTAINER sri.devapp.com
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
RUN apt-get update && apt-get upgrade -y
COPY /php/* /var/www/html/
EXPOSE 80