IMAGES := $(shell ls Dockerfile.* | sed 's/Dockerfile.//')
TAG := $(shell date +%s)

all: $(IMAGES)

cpp: base
tools: base
python: base
extra: base
java: base
haskell: base
circuits: base

%: Dockerfile.%
	docker build -t jutgeorg/$*:latest -f Dockerfile.$* .

.PHONY: all

publish: all
	@for image in $(IMAGES); do \
		docker tag jutgeorg/$$image:latest jutgeorg/$$image:$(TAG); \
		docker push jutgeorg/$$image:$(TAG); \
		docker push jutgeorg/$$image:latest; \
	done