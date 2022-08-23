#!/bin/bash

#
# Start Dev Server
#

# Start Docker
(cd ../deployment/dev && bash start.sh)

# Start Phoenix Dev Server
export WEBHOOK_URL="http://localhost:5481/post" # httpbin
export WEBHOOK_KEY="1234"

mix deps.get
mix ecto.migrate
mix phx.server

(cd ../deployment/dev && docker-compose down)