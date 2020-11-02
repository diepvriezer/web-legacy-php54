FROM php:5.4-apache

ENV APACHE_RUN_DIR /tmp/
ENV APACHE_LOG_DIR /tmp/

# Update packages first, next configure PHP and finally Apache.
RUN apt-get update && \
    apt-get install --yes --force-yes cron g++ gettext libicu-dev \
        openssl libc-client-dev libkrb5-dev libxml2-dev libfreetype6-dev \
        libgd-dev libmcrypt-dev bzip2 libbz2-dev libtidy-dev \
        libcurl4-openssl-dev libz-dev libmemcached-dev libxslt-dev && \
    docker-php-ext-install bcmath && \
    docker-php-ext-install bz2 && \
    docker-php-ext-install calendar && \
    docker-php-ext-install dba && \
    docker-php-ext-install exif && \
    docker-php-ext-configure gd --with-freetype-dir=/usr --with-jpeg-dir=/usr && \
    docker-php-ext-install gd && \
    docker-php-ext-install gettext && \
    docker-php-ext-install intl && \
    docker-php-ext-install mcrypt && \
    docker-php-ext-install mysql mysqli pdo pdo_mysql && \
    docker-php-ext-install soap && \
    docker-php-ext-install tidy && \
    docker-php-ext-install xmlrpc && \
    docker-php-ext-install mbstring && \
    docker-php-ext-install xsl && \
    docker-php-ext-install zip && \
    (yes '' | pecl install -f apc) && \
    docker-php-ext-configure hash --with-mhash && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    a2enmod rewrite  && \
    a2enmod headers && \
    a2ensite 000-default && \
    apache2ctl restart