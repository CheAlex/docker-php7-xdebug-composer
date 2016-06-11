FROM php:7.0-fpm

MAINTAINER Wenzel Pünter <wenzel@phelix.me>

RUN apt-get update -yqq && apt-get install -y libsqlite3-dev libicu-dev libfreetype6-dev libmcrypt-dev libjpeg62-turbo-dev libpng12-dev git libcurl4-gnutls-dev libbz2-dev -yqq
RUN docker-php-ext-install opcache pdo_sqlite curl json intl xml zip bz2 bcmath calendar mbstring mcrypt pdo_mysql
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd

RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

RUN pecl install intl
RUN docker-php-ext-install intl

RUN curl -sS https://getcomposer.org/installer | php
RUN php composer.phar install --verbose --no-interaction
