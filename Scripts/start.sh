#!/bin/bash

# Exit with error if a command returns a non-zero status
set -e

# Start service sendmail
service sendmail start

# Run php-fpm as last process that keeps running, otherwise docker container will exit
exec php5-fpm
