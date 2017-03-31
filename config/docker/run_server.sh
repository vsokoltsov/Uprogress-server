rake db:create
rake db:migrate
./bin/bundle exec rake tmp:clear
rm -f /var/www/uprogress/tmp/pids/server.pid
./bin/bundle install
./bin/bundle exec rails server -p 3000 -b 0.0.0.0
bundle exec sidekiq -d -L log/sidekiq.log  -e production
