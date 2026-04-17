all:
	docker build --network=host -t jutgeorg/jutge-all:latest -f Dockerfile.all .

prune:
	docker system prune -f