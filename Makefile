UID := $(shell id -u)
GID := $(shell id -g)
ARGS := --build-arg UID=$(UID) --build-arg GID=$(GID)

all: lite server full test
test: base
lite: base
server-base: base
server: server-base
full: server-base

%: Dockerfile.%
	docker build $(ARGS) -t jutge-org/$* -f Dockerfile.$* .

.PHONY: all

clean:
	docker image rm jutge-org/server-base jutge-org/base jutge-org/lite jutge-org/server jutge-org/full