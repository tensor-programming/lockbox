.PHONY: help compile-cli compile-server

CARGO ?= `which cargo`
MIX ?= `which mix`
MIX_CMD ?= MIX_EXS=lockbox_server/mix.exs $(MIX)
CLI_PATH ?= "./lockbox_cli"
MIX_EXS ?= "lockbox_server/mix.exs"

help: 
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

compile-cli: ## build the cli binary
	$(CARGO) build --manifest-path $(CLI_PATH)/Cargo.toml --release

compile-server: ## build the server
	MIX_ENV=release $(MIX_CMD) deps.get --only-release
	MIX_ENV=release $(MIX_CMD) release

compile: compile-cli compile-server ## build all
