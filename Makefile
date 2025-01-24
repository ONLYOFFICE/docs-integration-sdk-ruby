GEM_NAME := onlyoffice-docs_integration_sdk

.PHONY: help
help: # Show available recipes
	@echo "Recipes:"
	@grep --extended-regexp "^[a-z-]+: #" "$(MAKEFILE_LIST)" | \
		awk 'BEGIN {FS = ": # "}; {printf "  %-7s    %s\n", $$1, $$2}'

.PHONY: dev
dev: \
	export BUNDLE_WITH := development
dev: # Install development dependencies and generate RBI files
	@bundle install
	@bundle exec tapioca init

.PHONY: prod
prod: \
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
doc: # Generate YARD documentation
	@bundle exec yard --exclude _test.rb --plugin sorbet --markup markdown lib

.PHONY: lint
lint: # Run RuboCop linter
	@bundle exec rubocop

.PHONY: test
test: # Run test suite
	@bundle exec rake test

.PHONY: type
type: # Run Sorbet type checker
	@bundle exec srb tc --ignore example
