IMAGES := $(shell ls Dockerfile.* | sed 's/Dockerfile.//')
TAG := $(shell date +%s)

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

publish: all
	@for image in $(IMAGES); do \
		docker tag jutge-org/$$image:latest ghcr.io/jutge-org/$$image:$(TAG); \
		docker push ghcr.io/jutge-org/$$image:$(TAG); \
	done