UID := $(shell id -u)
GID := $(shell id -g)

all: lite server full
lite: base
server-base: base
server: server-base
full: server-base

%: Dockerfile.%
	docker build -t jutge-org/$* -f Dockerfile.$* --build-arg UID=$(UID) --build-arg GID=$(GID) .

.PHONY: all

clean:
	docker image rm jutge-org/server-base jutge-org/base jutge-org/lite jutge-org/server jutge-org/full 