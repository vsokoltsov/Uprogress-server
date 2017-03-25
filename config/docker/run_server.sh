rake db:create
rake db:migrate
./bin/bundle exec rake tmp:clear
rm -f /var/www/docker_example/tmp/pids/server.pid && ./bin/bundle exec rails server -p 3000 -b 0.0.0.0
