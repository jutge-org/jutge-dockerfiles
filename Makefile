all: full lite server

full:
	docker build -t jutge-full . --build-arg type=full

lite:
	docker build -t jutge-lite . --build-arg type=lite

server:
	docker build -t jutge-server . --build-arg type=server

install:
	cp j /usr/local/bin
