# Pull base image
FROM ubuntu:14.04

MAINTAINER Sebastian Helzle sebastian@helzle.net

# Update sources
RUN apt-get update

# Install php-fpm environment
RUN apt-get install php5-fpm php5-cli php5-mysql -y

# Create user for volume access
RUN (adduser --system --uid=1000 --gid=50 \
        --home /home/guest --shell /bin/bash guest)

# Default command to start php-fpm
CMD php5-fpm

# Open port for php-fpm
EXPOSE 9000
