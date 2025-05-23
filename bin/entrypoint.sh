#!/usr/bin/env bash

# Create DB and tables for docker container
rake db:create

rake db:migrate

# Start app
exec "$@"