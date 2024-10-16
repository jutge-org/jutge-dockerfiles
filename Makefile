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
	docker build -t jutgeorg/$*:latest -f Dockerfile.$* .

.PHONY: all

publish: all
	@for image in $(IMAGES); do \
		docker tag jutgeorg/$$image:latest jutgeorg/$$image:$(TAG); \
		docker push jutgeorg/$$image:$(TAG); \
	done