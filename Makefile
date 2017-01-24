.PHONY: docker build remove-tls new-tls tls

docker-create:
	./scripts/docker.sh

docker-start:
	docker start ngrokd

docker-run:
	docker start -i ngrokd

docker-stop:
	docker stop ngrokd

build:
	./scripts/build.sh

run:
	./scripts/run.sh

remove-tls:
	rm -rf tls

new-tls: remove-tls tls

tls:
	./scripts/generate_tls.sh
