.DEFAULT_GOAL := help

IMAGE_NAME := typescript-kata-name

help:  ## Show this help.
	@grep -E '^\S+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "%-30s %s\n", $$1, $$2}'

check-deps: ## Check if the dependencies we need to run this Makefile are installed
	@sh ./scripts/check-deps.sh

deps:
	docker compose run --rm -e CI= typescript-kata-name npm ci

.PHONY: local-setup
local-setup: deps ## Set up the local environment (e.g. install git hooks)
	scripts/local-setup.sh

.PHONY: clean
clean: ## General clean-up: delete 'node_modules' folder and Docker image
	rm -rf node_modules && (docker rmi typescript-kata-name || true) && docker volume prune --force

.PHONY: build
build: ## Builds the Docker image
	docker compose build $(IMAGE_NAME) --no-cache

.PHONY: check-dockerfile
check-dockerfile: ## Validate the Dockerfile
	docker run --rm -i hadolint/hadolint:latest-alpine < Dockerfile

.PHONY: check-typing
check-typing:  ## Check typing (implicit when compiling using tsc)
	docker compose run --rm --no-deps $(IMAGE_NAME) npm run build

.PHONY: check-format
check-format: ## Check the format (using black)
	docker compose run --rm --no-deps $(IMAGE_NAME) npm run lint

.PHONY: fix-format
fix-format:  ## Format code
	docker compose run --rm --no-deps $(IMAGE_NAME) npm run lint:fix

.PHONY: test
test: ## Run all the tests
	docker compose run --rm --no-deps $(IMAGE_NAME) npm run test

.PHONY: test-clear
test-clear: ## Clean up tests cache
	docker compose run --rm --no-deps $(IMAGE_NAME) npm run test:clear

.PHONY: test-coverage
test-coverage: ## Generate an HTML test coverage report after running all the tests
	docker compose run --rm typescript-kata-name npm run test:coverage
	@echo "You can find the generated coverage report here: ${PWD}/coverage/index.html"

.PHONY: pre-commit
pre-commit: check-format check-typing test

.PHONY: shell
shell: ## Get into the Docker container
	docker compose run --rm typescript-kata-name sh

.PHONY: rename-project
rename-project: ## Rename project: 'make rename new-name=<new-name>'
	sed -i 's/typescript-kata-name/$(new-name)/' docker-compose.yaml
	sed -i 's/typescript-kata-name/$(new-name)/' Makefile
	sed -i 's/typescript-kata-name/$(new-name)/' package.json
	sed -i 's/typescript-kata-template/$(new-name)/' README.md
	sed -i 's/typescript-kata-template/$(new-name)/' Makefile
