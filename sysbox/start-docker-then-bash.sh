#!/usr/bin/env bash
set -e

# Execute the docker daemon. This instance will run _inside_ the container!
# So it is a separate docker daemon, whose containers are not visible outside.
# What about the images???
dockerd > /var/log/dockerd.log 2>&1 &

# Then execute the specified command
exec "$@"