FROM php:7.0-fpm

MAINTAINER Wenzel Pünter <wenzel@phelix.me>

# Install developer dependencies
RUN apt-get update -yqq && apt-get install -y libsqlite3-dev libxml2-dev libicu-dev libfreetype6-dev libmcrypt-dev libjpeg62-turbo-dev libpng12-dev git libcurl4-gnutls-dev libbz2-dev libssl-dev -yqq

# Install php extensions
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install pdo_sqlite
RUN docker-php-ext-install opcache
RUN docker-php-ext-install json
RUN docker-php-ext-install calendar
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install xml
RUN docker-php-ext-install zip
RUN docker-php-ext-install bz2
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install mcrypt
RUN docker-php-ext-install curl

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd

# Install PECL extensions
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

RUN pecl install phar
RUN docker-php-ext-install phar

RUN pecl install intl
RUN docker-php-ext-install intl

# Install composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# Install PHP tools
RUN composer global require phpunit/phpunit
RUN composer global require phpunit/php-code-coverage
RUN composer global require phpunit/dbunit
RUN composer global require phpdocumentor/phpdocumentor
RUN composer global require sebastian/phpcpd
RUN composer global require phploc/phploc
RUN composer global require phpmd/phpmd

# Install commonly used PHP frameworks
RUN composer global require doctrine/orm
RUN composer global require giggsey/libphonenumber-for-php
RUN composer global require ircmaxell/random-lib
RUN composer global require psr/log
RUN composer global require symfony/polyfill-mbstring
RUN composer global require monolog/monolog
RUN composer global require symfony/yaml
RUN composer global require guzzlehttp/guzzle
RUN composer global require guzzlehttp/psr7
RUN composer global require twig/twig
RUN composer global require league/flysystem
RUN composer global require pimple/pimple
