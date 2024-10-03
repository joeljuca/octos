# Makefile. https://www.gnu.org/software/make/


# Project-wide

.PHONY: setup
setup:
	make build \
	&& make db.setup

.PHONY: build
build:
	mix do deps.get + compile

.PHONY: run
run:
	mix phx.server


# Code quality

.PHONY: lint
lint:
	mix format --check-formatted

.PHONY: fmt
fmt:
	mix format

.PHONY: test
test:
	mix test

.PHONY: test.watch
test.watch:
	find -E lib test -regex .*exs?$ | entr -c mix test


# Database

.PHONY: db.setup
db.setup:
	make db.create \
	&& make db.migrate

.PHONY: db.create
db.create:
	mix ecto.create

.PHONY: db.migrate
db.migrate:
	mix ecto.migrate

.PHONY: db.seed
db.seed:
	mix run priv/repo/seeds.exs

.PHONY: db.drop
db.drop:
	mix ecto.drop

.PHONY: db.reset
db.reset:
	make db.drop \
	&& make db.setup


# REPL

.PHONY: repl
repl:
	iex -S mix

.PHONY:repl.run
repl.run:
	iex -S mix phx.server
