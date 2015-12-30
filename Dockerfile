# Pull base image
FROM ubuntu:14.04

MAINTAINER Sebastian Helzle <sebastian@helzle.net>
MAINTAINER Visay Keo        <visay@web-essentials.asia>

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

# Upgrade the base system
RUN apt-get update && apt-get upgrade -y -q --no-install-recommends && apt-get install -y --no-install-recommends software-properties-common

# Add ppa for PHP 7.0
RUN apt-get install -y language-pack-en-base && LC_ALL=en_US.UTF-8 add-apt-repository -y ppa:ondrej/php-7.0

# Install packages as per recommendation (https://docs.docker.com/articles/dockerfile_best-practices/)
# And clean up APT
RUN apt-get update && apt-get install -y --no-install-recommends \
    php7.0-fpm \
    php7.0-cli \
    php7.0-mysql \
    php7.0-gd \
    imagemagick \
    ghostscript \
    sqlite3 \
    php7.0-sqlite3 \
    curl \
    php7.0-curl \
    php7.0-ldap \
    sendmail \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# TODO: Re-enable imagick, redis, xdebug modules once they are available

# Set workdir to project root
WORKDIR /var/www

# Copy configuration files for php
COPY Configuration/App/php.ini      Configuration/App/php-fpm.conf /etc/php/7.0/fpm/
COPY Configuration/App/www.conf     /etc/php/7.0/fpm/pool.d/
COPY Configuration/App/php-cli.ini  /etc/php/7.0/cli/php.ini

# Entry point script which wraps all commands for app container
COPY Scripts/EntryPoint/app.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# By default start php-fpm
CMD ["php-fpm7.0"]

