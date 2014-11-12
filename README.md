# How to get it running

## Install docker

    https://docs.docker.com/installation/

## Install fig

    http://www.fig.sh/install.html


## Change settings where needed

server_name: Docker/Config/nginx_vhost.conf

## Setup project vhost

Copy nginx project vhost config `Docker/Config/nginx_vhost.conf.sample` into the Web folder of the project and name it `.nginx.conf`

## Install Flow or Neos into the distribution folder

## Run it

`fig up -d`

# Tipps & Tricks

## Running a shell in one of the service containers

`fig run SERVICE /bin/bash`

## Check open ports in a container

`fig run SERVICE netstat --listen`

# Further reading

* http://mattiasgeniar.be/2014/04/09/a-better-way-to-run-php-fpm/
* http://www.lonelycoder.be/nginx-php-fpm-mysql-phpmyadmin-on-ubuntu-12-04/
* http://docs.docker.com/reference/builder/
* https://github.com/million12/docker-typo3-neos/blob/master/fig.yml
* http://www.fig.sh/yml.html
* https://gist.github.com/iwyg/4c8c0c0dec21dcfc8969
