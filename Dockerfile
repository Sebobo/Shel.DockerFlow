# Pull base image
FROM ubuntu:14.04

MAINTAINER Sebastian Helzle sebastian@helzle.net

# Update sources
RUN apt-get update

# Install php-fpm environment
RUN apt-get install php5-fpm php5-cli php5-mysql -y

# Install gd library
RUN apt-get install php5-gd -y

# Install packages for sendmail
RUN apt-get install sendmail -y

# Configure sendmail by sending "Yes" to all questions
RUN echo "Y\nY\nY\n" | sendmailconfig

# Create user for volume access (Needed for Mac OS)
RUN (adduser --system --uid=1000 --gid=50 \
        --home /home/guest --shell /bin/bash guest)

# Copy configuration files for php
COPY Configuration/App/php-fpm.conf /etc/php5/fpm/
COPY Configuration/App/php.ini      /etc/php5/fpm/
COPY Configuration/App/www.conf     /etc/php5/fpm/pool.d/
COPY Configuration/App/php-cli.ini  /etc/php5/cli/

# Default command to start php-fpm
CMD service sendmail start && php5-fpm

# Open port for php-fpm
EXPOSE 9000
