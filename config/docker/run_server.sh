echo "DIRECTORY IS $(pwd)"
bundle install
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake tmp:clear
if [ -f "/var/www/docker_example/tmp/pids/server.pid" ]; then
  echo "DELETE SERVER_PID"
  rm -f /var/www/docker_example/tmp/pids/server.pid
fi
bundle exec rails server -p 3000 -b 0.0.0.0
