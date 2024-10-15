IMAGES := $(shell ls Dockerfile.* | sed 's/Dockerfile.//')

all: $(IMAGES)
cpp: base
python: base
latex: base
extra: base
java: base
haskell: base

%: Dockerfile.%
	docker build -t jutge-org/$*:latest -f Dockerfile.$* .

.PHONY: all
