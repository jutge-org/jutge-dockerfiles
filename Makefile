all: full lite server

full:
	docker build -t jutge-full . --build-arg type=full

lite:
	docker build -t jutge-lite . --build-arg type=lite

server:
	docker build -t jutge-server . --build-arg type=server

install:
	cp jutge-run.sh /usr/local/bin/jutge-run
	cp jutge-submit.sh /usr/local/bin/jutge-submit
	cp jutge-start.py /usr/local/bin/jutge-start
	
