# Pull base image
FROM ubuntu:14.04

MAINTAINER Sebastian Helzle sebastian@helzle.net

# Install packages as per recommendation (https://docs.docker.com/articles/dockerfile_best-practices/)
RUN apt-get update && apt-get install -y \
    php5-fpm \
    php5-cli \
    php5-mysql \
    php5-gd \
    sendmail

# Configure sendmail by sending "Yes" to all questions
RUN echo "Y\nY\nY\n" | sendmailconfig

# Copy configuration files for php
COPY Configuration/App/php.ini Configuration/App/php-fpm.conf /etc/php5/fpm/
COPY Configuration/App/www.conf     /etc/php5/fpm/pool.d/
COPY Configuration/App/php-cli.ini  /etc/php5/cli/

# Script which wraps all commands
COPY Scripts/entrypoint.sh /usr/bin/
ENTRYPOINT ["/bin/bash", "/usr/bin/entrypoint.sh"]

# By default start sendmail service and php-fpm
CMD service sendmail start && php5-fpm

# Open port for php-fpm
EXPOSE 9000
