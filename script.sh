#! /bin/sh
gem install bundler
sleep 1
bundle install
sleep 1
sudo service postgresql start
psql postgres -c "CREATE USER username SUPERUSER PASSWORD 'password';"
createdb pre_employment_app_development
bundle exec rake db:migrate

