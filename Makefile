# We need the GID of the docker group on the host to pass it
# to docker build, so that the same GID is used in the container,
# otherwise the 'worker' user cannot access the docker socket.
DOCKER_GID := $(shell getent group docker | cut -d: -f3)

all: full lite server

jutge-vinga-source: 
	rm -rf jutge-vinga
	git clone github:jutge-org/jutge-vinga.git jutge-vinga-source

full:
	docker build -t jutge-full . --build-arg type=full

lite:
	docker build -t jutge-lite . --build-arg type=lite

server: jutge-vinga-source
	@echo $(DOCKER_GID)
	docker build -t jutge-server -f Dockerfile.server --build-arg DOCKER_GID=$(DOCKER_GID) .

test:
	docker build -t jutge-test . --build-arg type=test

