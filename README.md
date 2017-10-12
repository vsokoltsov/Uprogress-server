[![Build Status](https://travis-ci.org/vforvad/Uprogress-server.svg?branch=master)](https://travis-ci.org/vforvad/Uprogress-server)
[![Code Climate](https://codeclimate.com/github/vforvad/Uprogress-server/badges/gpa.svg)](https://codeclimate.com/github/vforvad/Uprogress-server)
[![Issue Count](https://codeclimate.com/github/vforvad/Uprogress-server/badges/issue_count.svg)](https://codeclimate.com/github/vforvad/Uprogress-server)

## Documentation

Documentation for API available [here](https://github.com/vforvad/Uprogress-server/wiki)

## Setup

* `docker-compose build` - build your application
* `docker-compose -run --rm app rake db:create db:migrate` - create database and run migrations
* `docker-compose run --service-ports app` - Running Rails server (due to the
  fact that `docket-compose up` does not provider port mapping)

## Specs

For accessing to specs you need to perform
`docker-compose run app bundle exec rake db:create RAILS_ENV=test` command

Also, if you want to run specs from command line, you should do it with `env` prefix
Like that `RAILS_ENV=test`
