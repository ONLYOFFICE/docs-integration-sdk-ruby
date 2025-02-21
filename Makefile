BUNDLER_VERSION := 2.4.22
TAPIOCA_WORKERS ?=
GEM_NAME := onlyoffice-docs_integration_sdk

.PHONY: help
help: # Show available recipes
	@echo "Recipes:"
	@grep --extended-regexp "^[a-z-]+: #" "$(MAKEFILE_LIST)" | \
		awk 'BEGIN {FS = ": # "}; {printf "  %-7s    %s\n", $$1, $$2}'

.PHONY: bundler
bundler: # Install Bundler
	@gem install bundler --version "$(BUNDLER_VERSION)"

.PHONY: dev
dev: \
	export BUNDLER_VERSION := $(BUNDLER_VERSION)
	export BUNDLE_WITH := development
	export TAPIOCA_WORKERS := $(TAPIOCA_WORKERS)
dev: # Install development dependencies and generate RBI files
	@bundle install
# https://github.com/Shopify/tapioca/issues/1368
ifdef TAPIOCA_WORKERS
	@mkdir -p sorbet/tapioca
	@rm -f sorbet/tapioca/config.yml
	@touch sorbet/tapioca/config.yml
	@yq --inplace \
		".gem.workers = env(TAPIOCA_WORKERS) | \
		.dsl.workers = env(TAPIOCA_WORKERS) | \
		.check_shims.workers = env(TAPIOCA_WORKERS)" \
		sorbet/tapioca/config.yml
endif
	@bundle exec tapioca init

.PHONY: prod
prod: \
	export BUNDLER_VERSION := $(BUNDLER_VERSION)
	export BUNDLE_WITHOUT := development
prod: # Install production dependencies only
	@bundle install

.PHONY: local
local: # Install locally built gem
	@gem install "$(GEM_NAME).gem"

.PHONY: gem
gem: # Build gem
	@gem build --output "$(GEM_NAME).gem" --strict "$(GEM_NAME).gemspec"

.PHONY: image
image: # Build Docker image
	@docker build --tag "$(GEM_NAME)" .

.PHONY: doc
doc: \
	export BUNDLER_VERSION := $(BUNDLER_VERSION)
doc: # Generate YARD documentation
	@bundle exec yard --exclude _test.rb --plugin sorbet --markup markdown lib

.PHONY: lint
lint: \
	export BUNDLER_VERSION := $(BUNDLER_VERSION)
lint: # Run RuboCop linter
	@bundle exec rubocop

.PHONY: test
test: \
	export BUNDLER_VERSION := $(BUNDLER_VERSION)
test: # Run test suite
	@bundle exec rake test

.PHONY: test-fork
test-fork: \
	export BUNDLER_VERSION := $(BUNDLER_VERSION)
test-fork: # Run each test in a separate process
	@bundle exec rake test_fork

.PHONY: type
type: \
	export BUNDLER_VERSION := $(BUNDLER_VERSION)
type: # Run Sorbet type checker
	@bundle exec srb tc --ignore example
