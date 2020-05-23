#!/bin/bash
# docker-compose rm $(docker ps -q -f status=exited)
echo "Running tests in a fully containerized environment ====>"
docker-compose up -d mysql user
sleep 15
docker-compose run user bundle exec rails db:create db:migrate
echo "Databse created ====>"
docker-compose run user bundle exec rails test
