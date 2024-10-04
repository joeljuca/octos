# Octos

[![GitHub Actions](https://github.com/joeljuca/octos/actions/workflows/elixir.yaml/badge.svg)](https://github.com/joeljuca/octos/actions/workflows/elixir.yaml)

My solution for the Elixir challenge of Octos AI.

## Setup

Set everything up quickly with:

```
$ make setup
```

## Develop

You can run the server in dev mode with:

```
$ make run
```

Optionally, you can run it within an IEx session to interact with the system through an Elixir CLI with:

```
$ make repl.run
```

In either case, the server must be available in http://localhost:4000.

### The `Makefile`

This project provides a `Makefile` with a common `make`-based CLI interface:

- **Project chores**
  - `make setup`
  - `make build`
  - `make run`
- **Code quality**
  - `make lint`
  - `make fmt`
  - `make test`
  - `make test.watch`
- **Database**
  - `make db.setup`
  - `make db.create`
  - `make db.migrate`
  - `make db.seed`
  - `make db.drop`
  - `make db.reset`
- **REPL**
  - `make repl`
  - `make repl.run`

## Test

Run tests with:

```
$ make test
```

Run tests continuously during development with:

```
$ make test.watch
```

> 💡 You'll need [entr](https://github.com/eradman/entr) set up to use this Make task.

## License

&copy; 2024 Joel Jucá. All rights reserved
