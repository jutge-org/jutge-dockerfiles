all: full lite server

jutge-vinga-source: 
	rm -rf jutge-vinga
	git clone github:jutge-org/jutge-vinga.git jutge-vinga-source

full:
	docker build -t jutge-full . --build-arg type=full

lite:
	docker build -t jutge-lite . --build-arg type=lite

server: jutge-vinga-source
	docker build -t jutge-server -f Dockerfile.server .

test:
	docker build -t jutge-test . --build-arg type=test

