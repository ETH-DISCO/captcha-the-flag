# --------------------------------------------------------------- utils

.PHONY: fmt # format and remove unused imports
fmt:
	# python
	pip install isort
	isort .

	pip install autoflake
	autoflake --remove-all-unused-imports --recursive --in-place .

	pip install ruff
	ruff format --config line-length=500 .

	# python javascript
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
	git commit -m "up"
	git push

# --------------------------------------------------------------- docker

.PHONY: docker-install # run docker container
docker-install:
	# @echo "to exec into docker container, run: 'docker exec -it <container-name> /bin/bash'"
	docker-compose up --detach

.PHONY: docker-clean # wipe everything in docker
docker-clean:
	docker-compose down

	# wipe docker
	-docker stop $$(docker ps -a -q)
	-docker rm $$(docker ps -a -q)
	-docker rmi $$(docker images -q)
	yes | docker container prune
	yes | docker image prune
	yes | docker volume prune
	yes | docker network prune
	yes | docker system prune
	
	# check if successful
	docker ps --all
	docker images
	docker system df
	docker volume ls
	docker network ls

# --------------------------------------------------------------- help

.PHONY: help # generate help message
help:
	@grep '^.PHONY: .* #' Makefile | sed 's/\.PHONY: \(.*\) # \(.*\)/\1	\2/' | expand -t20
