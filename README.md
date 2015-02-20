# Dockerflow helps you developing TYPO3 Flow and Neos projects

DockerFlow creates the necessary Docker containers (webserver, database, php, mail) to run 
your TYPO3 Flow/Neos project. The package provides a wrapper script in `bin/dockerflow` which simplifies the 
handling of docker and does all the configuration necessary.

We created this package to make development on TYPO3 Flow and Neos projects easier and to create a simple 
reusable package which can easily be maintained and serves well for the standard project.

Development will continue further as the package is already reused in several projects.
Contributions and feedback are very welcome.

## Install docker

    https://docs.docker.com/installation/

## Install fig

We use fig to do all the automatic configuration:

    http://www.fig.sh/install.html

The repository contains a Dockerfile which will automatically be built in the
[docker hub](https://registry.hub.docker.com/u/sebobo/shel.dockerflow/) after each change
and used by fig to build the necessary containers.

## On a Mac or Windows install boot2docker

    http://boot2docker.io
    
You will not have a performance as good as on linux but it's workable.
Checkout the [boot2docker support](https://github.com/Sebobo/Shel.DockerFlow/tree/boot2docker-support) branch of
dockerflow for a Vagrantfile which builds a boot2docker instance with working NFS shared.
This makes it much faster (still not as fast as on linux).

## Install dockerflow into your distribution

Add `shel/dockerflow@dev-master` as dev dependency and run `composer install`.

## Run dockerflow

    bin/dockerflow up -d
    
The command will echo the url with which you can access your project.
Add the hostname then to your `/etc/hosts` and set the ip to your docker host (default for linux is 0.0.0.0)
or your boot2docker ip. The parameter `-d` will keep it running in the background until you run:

    bin/dockerflow stop

The default database configuration for your `Settings.yaml` is:

    TYPO3:
      Flow:
        persistence:
          backendOptions:
            dbname: neos
            user: root
            password: ''
            host: db
            driver: pdo_mysql

## Check the status

    bin/dockerflow ps

This will show the running containers. The `data` container can be inactive to do it's work.

# Tips & Tricks

## Using different FLOW_CONTEXT

    FLOW_CONTEXT=Production bin/dockerflow up -d
    
## Runnig flow commands

We added a little helper to run Flow commands without the whole path. Example:

    bin/dockerflow run app flow --help

## Keep Flow caches in the container to improve performance (especially with boot2docker)

Add this configuration to your `Settings.yaml` in Flow:

    TYPO3:
      Flow:
        utility:
          environment:
            temporaryDirectoryBase: /tmp/dockerflow/Temporary/

## Using MailHog to test mailing

Add this configuration to your`Settings.yaml`:

    TYPO3:
      SwiftMailer:
         transport:
           type: 'Swift_SmtpTransport'
           options:
             host: 'mail'
             port: 1025

And open `MyNeosProject:8025` in your browser (use your own hostname) to see your mails.

Send emails from your Flow app and have fun.

## Running a shell in one of the service containers

    bin/dockerflow run SERVICE /bin/bash

SERVICE can currently be `app`, `web`, `data` or `db`.

## Access database inside container from docker host

While you can easily login to shell of the `db` container with `bin/dockerflow run db /bin/bash`
and execute your mysql commands, there are some cases that you want to run mysql commands directly
from your host without having to login to the `db` container first. One of the best use cases,
for example, is to access the databases inside the container from MySQL Workbench tool.
To be able to do that, we have mapped database port inside the container (which is `3306`) to your
host machine through `3307` port.

![Screenshot of MySQL Workbench interface](/docs/MySQL-Workbench.png "MySQL Workbench interface")

## Running functional test for Flow package

DockerFlow installs by default `sqlite` in the base image so that functional tests can be run out-of-the-box.
Example below is for running all functional tests of TYPO3.Flow package in one-off command:

    bin/dockerflow run app /var/www/bin/phpunit -c /var/www/Build/BuildEssentials/PhpUnit/FunctionalTests.xml /var/www/Packages/Framework/TYPO3.Flow/Tests/Functional/

Make sure you run composer install with `--dev` mode when setting up your Flow project
and adjust the path to the test directory of your own package.

## Attach to a running service

Run `bin/dockerflow ps` and copy the container's name that you want to attach to.

Run `docker exec -it <containername> /bin/bash` with the name you just copied.
With this you can work in a running container instead of creating a new one.

## Check open ports in a container

    bin/dockerflow run SERVICE netstat --listen

# Further reading

* [blog post on php-fpm](http://mattiasgeniar.be/2014/04/09/a-better-way-to-run-php-fpm/)
* [nginx+php-fpm+mysql tutorial](http://www.lonelycoder.be/nginx-php-fpm-mysql-phpmyadmin-on-ubuntu-12-04/)
* [Docker documentation](http://docs.docker.com/reference/builder/)
* [fig documentation](http://www.fig.sh/yml.html)
* [nginx.conf for Flow](https://gist.github.com/iwyg/4c8c0c0dec21dcfc8969)
* [boot2docker version which supports nfs](https://vagrantcloud.com/yungsang/boxes/boot2docker)
* [MailHog](https://github.com/mailhog/MailHog/)
