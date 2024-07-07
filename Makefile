.DEFAULT_GOAL := help

IMAGE_NAME := islomar/typescript-kata-template

help:  ## Show this help.
	@grep -E '^\S+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "%-30s %s\n", $$1, $$2}'

check-deps: ## Check if the dependencies we need to run this Makefile are installed
	@sh ./scripts/check-deps.sh

.PHONY: local-setup
local-setup: ## Set up the local environment (e.g. install git hooks)
	scripts/local-setup.sh

.PHONY: build
build: ## Builds the Docker image
	docker build -t $(IMAGE_NAME) .

.PHONY: check-dockerfile
check-dockerfile: ## Validate the Dockerfile
	docker run --rm -i hadolint/hadolint:latest-alpine < Dockerfile

.PHONY: check-typing
check-typing:  ## Check types (using mypy)
	docker compose run --rm --no-deps $(IMAGE_NAME) npm run tsc

.PHONY: check-format
check-format: ## Check the format (using black)
	docker compose run --rm --no-deps $(IMAGE_NAME) npm run lint

.PHONY: fix-format
fix-format:  ## Format Python code
	docker compose run --rm --no-deps $(IMAGE_NAME) npm run lint:fix

.PHONY: test
test: ## Run all the tests
	docker compose run --rm --no-deps typescript-kata-name npm run test

.PHONY: test-coverage
test-coverage: ## Generate an HTML test coverage report after running all the tests
	docker compose run --rm typescript-kata-name poetry run coverage run --branch -m pytest tests
	docker compose run --rm typescript-kata-name poetry run coverage html
	@echo "You can find the generated coverage report here: ${PWD}/htmlcov/index.html"

.PHONY: pre-commit
pre-commit: check-format check-typing check-style test

.PHONY: shell
shell: ## Get into the Docker container
	docker compose run --rm typescript-kata-name sh

.PHONY: rename-project
rename-project: ## Rename project: 'make rename new-name=<new-name>'
	sed -i 's/typescript-kata-name/$(new-name)/' docker-compose.yaml
	sed -i 's/typescript-kata-name/$(new-name)/' Makefile
	sed -i 's/typescript-kata-name/$(new-name)/' package.json
	sed -i 's/python-kata-template/$(new-name)/' README.md
	sed -i 's/python-kata-template/$(new-name)/' Makefile
