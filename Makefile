all: lite server full

%:
	docker build -t jutge.org:$* --build-arg type=$* .

.PHONY: all