.DEFAULT_GOAL := help

IMAGE_NAME := typescript-kata-name

help:  ## Show this help.
	@grep -E '^\S+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "%-30s %s\n", $$1, $$2}'

check-deps: ## Check if the dependencies we need to run this Makefile are installed
	@sh ./scripts/check-deps.sh

deps: ## Install all dependencies
	npm install

.PHONY: local-setup
local-setup: deps ## Set up the local environment (e.g. install git hooks)
	scripts/local-setup.sh

.PHONY: clean
clean: ## General clean-up: delete 'node_modules' folder
	rm -rf node_modules

.PHONY: build
build: ## Builds the Docker image
	npm run build

.PHONY: check-typing
check-typing:  ## Check typing (implicit when compiling using tsc)
	npm run build

.PHONY: check-format
check-format: deps ## Check the format (using black)
	npm run lint

.PHONY: fix-format
fix-format:  ## Format code
	npm run lint:fix

.PHONY: test
test: ## Run all the tests
	npm run test

.PHONY: test-watcher
test-watch: ## Run all the tests
	npm run test:watch

.PHONY: test-clear
test-clear: ## Clean up tests cache
	npm run test:clear

.PHONY: test-coverage
test-coverage: ## Generate an HTML test coverage report after running all the tests
	npm run test:coverage
	@echo "You can find the generated coverage report here: ${PWD}/coverage/index.html"

.PHONY: pre-commit
pre-commit: check-format check-typing test


.PHONY: rename-project
rename-project: ## Rename project: 'make rename new-name=<new-name>'
	sed -i 's/typescript-kata-name/$(new-name)/' docker-compose.yaml
	sed -i 's/typescript-kata-name/$(new-name)/' Makefile
	sed -i 's/typescript-kata-name/$(new-name)/' package.json
	sed -i 's/typescript-kata-template/$(new-name)/' README.md
	sed -i 's/typescript-kata-template/$(new-name)/' Makefile
