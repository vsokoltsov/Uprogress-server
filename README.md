## Setup and run
For installing `docker` environment use command `docker-compose build`

Then you need to create database and run migrations
`docker-compose run app bundle exec rake db:create db:migrate`
(And maybe `db:seed` for seeds)

After that, you can run server with
`docker-compose up` (or `docker-compose up -d in background`)
