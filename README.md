## Setup and run

First of all, pleas make sure, that you install docker fully and properly (`docker-machine`,
  `docker-compose`, `kinematic`, `boot2docker` and all that stuff. See [official guide](https://docs.docker.com/toolbox/toolbox_install_mac/)

For installing `docker` environment use command `docker-compose build`

Then you need to create database and run migrations
`docker-compose run app bundle exec rake db:create db:migrate`
(And maybe `db:seed` for seeds)

After that, you can run server with
`docker-compose run --service-ports app` (in development, with support of debug and code reload)

You may want to add an `alias dc="docker-compose run app"` for quick access to rails ecosystem commands.
Or add `192.168.99.100` to `/etc/hosts` with `dockerhost` or something

## Specs

For accessing to specs you need to perform
`docker-compose run app bundle exec rake db:create RAILS_ENV=test` command

Also, if you want to run specs from command line, you should do it with `env` prefix
Like that `RAILS_ENV=test`

## Console

For accessing to console (running specs, rake tasks, etc.)
call this `docker exec -it uprogressserver_app_run_1 /bin/bash`
