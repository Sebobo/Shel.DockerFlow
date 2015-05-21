# Pull base image
FROM ubuntu:14.04

MAINTAINER Sebastian Helzle sebastian@helzle.net

# Install packages as per recommendation (https://docs.docker.com/articles/dockerfile_best-practices/)
# And clean up APT
RUN apt-get update && apt-get install -y --no-install-recommends \
    php5-fpm \
    php5-cli \
    php5-mysql \
    php5-gd \
    php5-imagick \
    sqlite \
    php5-sqlite \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy configuration files for php
COPY Configuration/App/php.ini Configuration/App/php-fpm.conf /etc/php5/fpm/
COPY Configuration/App/www.conf     /etc/php5/fpm/pool.d/
COPY Configuration/App/php-cli.ini  /etc/php5/cli/

# Script which wraps all commands
COPY Scripts/entrypoint.sh /usr/local/bin/
ENTRYPOINT ["/bin/bash", "/usr/local/bin/entrypoint.sh"]

# By default start php-fpm
CMD php5-fpm

# Set workdir to project root
WORKDIR /var/www
