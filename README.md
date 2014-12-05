# How to get it running

DockerFlow will create the necessary Docker containers to start your TYPO3 Flow/Neos distribution.

## Install docker

    https://docs.docker.com/installation/

## Install fig

    http://www.fig.sh/install.html

## Install Flow or Neos into the distribution folder

## Run it 

    `bin/fig up -d`

`-d` will let it stay in the background.

## Check the status

    `bin/fig ps`

This will show the running containers. The `data` container can be inactive to work. 

# Tipps & Tricks

## Using different FLOW_CONTEXT

    `FLOW_CONTEXT=Production bin/fig up -d`

## Running a shell in one of the service containers

    `bin/fig run SERVICE /bin/bash`

## Check open ports in a container

    `bin/fig run SERVICE netstat --listen`

# Further reading

* http://mattiasgeniar.be/2014/04/09/a-better-way-to-run-php-fpm/
* http://www.lonelycoder.be/nginx-php-fpm-mysql-phpmyadmin-on-ubuntu-12-04/
* http://docs.docker.com/reference/builder/
* https://github.com/million12/docker-typo3-neos/blob/master/fig.yml
* http://www.fig.sh/yml.html
* https://gist.github.com/iwyg/4c8c0c0dec21dcfc8969
