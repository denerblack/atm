#!/bin/bash

set -e
# Exit on fail

cd /app
bundle check || bundle install --binstubs="$BUNDLE_BIN"
bundle exec rake db:migrate
# Ensure all gems installed. Add binstubs to bin which has been added to PATH in Dockerfile.

exec "$@"
# Finally call command issued to the docker service
