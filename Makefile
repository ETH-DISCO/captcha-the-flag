# --------------------------------------------------------------- utils

.PHONY: fmt # format and remove unused imports
fmt:
	pip install isort
	isort .

	pip install autoflake
	autoflake --remove-all-unused-imports --recursive --in-place .

	pip install ruff
	ruff format --config line-length=500 .

	npm install --global prettier
	prettier . --write --print-width 500 --tab-width 4

.PHONY: sec # check for common vulnerabilities
sec:
	pip install bandit
	pip install safety
	
	bandit -r .
	safety check --full-report

.PHONY: reqs # generate requirements.txt file
reqs:
	pip install pipreqs
	rm -rf requirements.txt
	pipreqs .

.PHONY: up # pull remote changes and push local changes
up:
	git pull
	git add .
	@if [ -z "$(msg)" ]; then \
		git commit -m "up"; \
	else \
		git commit -m "$(msg)"; \
	fi
	git push

# --------------------------------------------------------------- docker

.PHONY: docker-install # run docker container
docker-install:
	# detach from container: `docker-compose up --detach`
	# exec into container: `docker exec -it <container-name> /bin/bash`
	docker-compose up

.PHONY: docker-clean # wipe docker
docker-clean:
	docker-compose down

	-docker stop $$(docker ps -a -q)
	-docker rm $$(docker ps -a -q)
	-docker rmi $$(docker images -q)
	yes | docker container prune
	yes | docker image prune
	yes | docker volume prune
	yes | docker network prune
	yes | docker system prune
	
	docker ps --all
	docker images
	docker system df
	docker volume ls
	docker network ls

# --------------------------------------------------------------- help

.PHONY: help # generate help message
help:
	@grep '^.PHONY: .* #' Makefile | sed 's/\.PHONY: \(.*\) # \(.*\)/\1	\2/' | expand -t20
