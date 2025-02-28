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
