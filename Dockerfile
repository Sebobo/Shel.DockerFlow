# Pull base image
FROM phusion/baseimage:0.9.16

MAINTAINER Sebastian Helzle sebastian@helzle.net

# Install packages as per recommendation (https://docs.docker.com/articles/dockerfile_best-practices/)
RUN apt-get update && apt-get install -y --no-install-recommends \
    php5-fpm \
    php5-cli \
    php5-mysql \
    php5-gd \
    sendmail

# Configure sendmail by sending "Yes" to all questions
RUN echo "define(confDOMAIN_NAME, dockerflow.dev)dnl" >> /etc/mail/sendmail.mc && echo "Y\nY\nY\n" | sendmailconfig

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy configuration files for php
COPY Configuration/App/php.ini Configuration/App/php-fpm.conf /etc/php5/fpm/
COPY Configuration/App/www.conf     /etc/php5/fpm/pool.d/
COPY Configuration/App/php-cli.ini  /etc/php5/cli/

# Script which wraps all commands
COPY Scripts/entrypoint.sh /usr/local/bin/
ENTRYPOINT ["/bin/bash", "/usr/local/bin/entrypoint.sh"]

# Add run script to start sendmail and php-fpm
RUN mkdir /etc/service/dockerflow
COPY Scripts/start.sh /etc/service/dockerflow/run

CMD ["/sbin/my_init"]

# Open port for php-fpm
EXPOSE 9000
