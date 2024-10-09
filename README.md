# Octos

[![GitHub Actions](https://github.com/joeljuca/octos/actions/workflows/elixir.yaml/badge.svg)](https://github.com/joeljuca/octos/actions/workflows/elixir.yaml)

## Setup

This project uses the following tools:

- [asdf](https://asdf-vm.com) (runtime versioning tool)
- [direnv](https://direnv.net) (env-loading tool; optional)

Make sure you have these set up in your system before proceeding.

### Runtimes

Install asdf plugins to manage Erlang and Elixir versions:

```sh
$ asdf plugin add erlang
$ asdf plugin add elixir
```

Then, install Erlang and Elixir versions used in the project:

```sh
$ asdf install
```

### Local config

You need to set up some required environment variables:

- `DATABASE_URL` (database connection string)

You'll find a template for such variables in [`.envrc.template`](.envrc.template).

> 💡 _We use and recommend [direnv](https://direnv.net), there's a `.envrc` template available:_
>
> ```sh
> # Duplicate the template as `.envrc`
> $ cp .envrc.template .envrc
> ```
>
> _Uncomment the variables and customize it as you need._

If your environment variables looks good, you should be able to set everything up quickly with:

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

### The seeding script `seeds.exs`

There's a seeding script available. It created 1K users with 50 cameras each (50K cameras in total).

Run it with:

```
$ mix run priv/repo/seeds.exs
```

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
