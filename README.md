[![Build Status](https://travis-ci.org/vforvad/Uprogress-server.svg?branch=master)](https://travis-ci.org/vforvad/Uprogress-server)

## Setup

First of all, pleas make sure, that you install docker fully and properly (`docker-machine`,
  `docker-compose`, `kinematic`, `boot2docker` and all that stuff. See [official guide](https://docs.docker.com/toolbox/toolbox_install_mac/)

For installing `docker` environment use command `docker-compose build`

Then you need to create database and run migrations
`docker-compose run app bundle exec rake db:create db:migrate`
(And maybe `db:seed` for seeds)

After that, you can run server with
`docker-compose run --service-ports app` (in development, with support of debug and code reload)

You may want to add an `alias dc="docker-compose run app"` for quick access to rails ecosystem commands.
Or add `docker-machine ip` value to `/etc/hosts` with `dockerhost` or something

## Run

For proper running you should do this steps (after installing other stuff)

# Boot2Docker

* install boot2docker via brew (`brew install boot2docker`)
* init virtual machine (`boot2docker init`)
* run virtual machin (`boot2docker up`)
* connect to docker daeon (`eval "$(boot2docker shellinit)"`)

# Docker-machine

You can see guide [here](https://docs.docker.com/machine/get-started/)

## Specs

For accessing to specs you need to perform
`docker-compose run app bundle exec rake db:create RAILS_ENV=test` command

Also, if you want to run specs from command line, you should do it with `env` prefix
Like that `RAILS_ENV=test`

## Console

For accessing to console (running specs, rake tasks, etc.)
call this `docker exec -it uprogressserver_app_run_1 /bin/bash`
