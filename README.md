[![Build Status](https://travis-ci.org/vforvad/Uprogress-server.svg?branch=master)](https://travis-ci.org/vforvad/Uprogress-server)
[![Code Climate](https://codeclimate.com/github/vforvad/Uprogress-server/badges/gpa.svg)](https://codeclimate.com/github/vforvad/Uprogress-server)
[![Issue Count](https://codeclimate.com/github/vforvad/Uprogress-server/badges/issue_count.svg)](https://codeclimate.com/github/vforvad/Uprogress-server)

## Documentation

Documentation for API available [here](https://github.com/vforvad/Uprogress-server/wiki)

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

**So, the main workflow for now is**
* Run `docker-compose build`
* Run `docker-compose up`
* Out of `docker-compose up` command
* Move to next paragraph

## Run

After all preparation steps you can run this commands:
* `dc bin/rake db:create` - Create database
* `dc bin/rake db:migrate` - Run migrations
* `dc bin/rake db:seed` - Run seeds
* `docker-compose run --rm --service-ports app bin/rails server -b 0.0.0.0` - run server

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
