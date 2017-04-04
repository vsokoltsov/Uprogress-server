./bin/bundle
./bin/bundle exec rake db:create
./bin/bundle exec rake db:migrate
./bin/bundle exec rake tmp:clear
if [ -f "/var/www/docker_example/tmp/pids/server.pid" ]; then
  echo "DELETE SERVER_PID"
  rm -f /var/www/docker_example/tmp/pids/server.pid
fi
./bin/bundle exec rails server -p 3000 -b 0.0.0.0
