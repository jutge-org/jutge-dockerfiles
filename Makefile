# We need the GID of the docker group on the host to pass it
# to docker build, so that the same GID is used in the container,
# otherwise the 'worker' user cannot access the docker socket.
DOCKER_GID := $(shell getent group docker | cut -d: -f3)
ARG := --build-arg DOCKER_GID=$(DOCKER_GID)

all: full lite server

jutge-vinga-source: 
	@rm -rf jutge-vinga
	@git clone github:jutge-org/jutge-vinga.git jutge-vinga-source

full: jutge-vinga-source
	docker build -t jutge-full -f Dockerfile.full $(ARG) .

lite: jutge-vinga-source
	docker build -t jutge-lite -f Dockerfile.lite $(ARG) . 

server: jutge-vinga-source
	docker build -t jutge-server -f Dockerfile.server $(ARG) .

test: jutge-vinga-source
	docker build -t jutge-test  -f Dockerfile.test $(ARG) . 

