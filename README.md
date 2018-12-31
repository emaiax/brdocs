# BrDocs

[![License](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)
[![Hex Version](https://img.shields.io/hexpm/v/brdocs.svg)](https://hex.pm/packages/brdocs)
[![Ebert](https://ebertapp.io/github/emaiax/brdocs.svg)](https://ebertapp.io/github/emaiax/brdocs)
[![Build Status](https://travis-ci.org/emaiax/brdocs.svg?branch=master)](https://travis-ci.org/emaiax/brdocs)
[![Coverage Status](https://coveralls.io/repos/github/emaiax/brdocs/badge.svg?branch=master)](https://coveralls.io/github/emaiax/brdocs?branch=master)

Elixir client to generate, validate and format different Brazilian docs.

`BrDocs` it's not `Ecto` specific, but has `Ecto` support. #ftw

_Currently supported docs: CPF, CNPJ_

> **This README follows master branch, which may not be the currently published version.**
>
> Here are the docs for the latest published version of [BrDocs](https://hexdocs.pm/brdocs/readme.html).

## Installation

#### To install in all environments (useful for generating seed data in dev/prod):

In `mix.exs`, add the `BrDocs` dependency:

```elixir
def deps do
  # Get the latest from hex.pm. Works with Ecto +2.x
  [
    {:brdocs, "~> 0.1"}
  ]
end
```

## Overview

[Check out the docs](http://hexdocs.pm/brdocs/BrDocs.html) for more details.

Generating valid (but fake) docs:

```elixir
iex> BrDocs.generate(:cpf)
%BrDocs.BrDoc{kind: :cpf, value: "12345678909"}

iex> BrDocs.generate(:cpf, formatted: true)
%BrDocs.BrDoc{kind: :cpf, value: "123.456.789-09"}

iex> BrDocs.generate(:cnpj)
%BrDocs.BrDoc{kind: :cnpj, value: "11444777000161"}

iex> BrDocs.generate(:cnpj, formatted: true)
%BrDocs.BrDoc{kind: :cnpj, value: "11.444.777/0001-61"}
```

Format docs:

```elixir
iex> BrDocs.format("12345678909", :cpf)
%BrDocs.BrDoc{kind: :cpf, value: "123.456.789-09"}

iex> BrDocs.format("11444777000161", :cnpj)
%BrDocs.BrDoc{kind: :cnpj, value: "11.444.777/0001-61"}
```

Validate docs:

```elixir
iex> BrDocs.validate(%BrDocs.BrDoc{kind: :cpf, value: "12345678909"})
true

iex> BrDocs.validate(%BrDocs.BrDoc{kind: :cpf, value: "12345678900"})
false

iex> BrDocs.validate(%BrDocs.BrDoc{kind: :cnpj, value: "11444777000161"})
true

iex> BrDocs.validate(%BrDocs.BrDoc{kind: :cnpj, value: "11444777000160"})
false
```

## Ecto Support

There is a validation functions to makes it easy to validate your Brazilian docs w/ Ecto.

  * `validate_doc` validates a Brazilian doc in your `Ecto.Changeset`.

Maybe, more to come.

Usage:

```elixir
defmodule User do
  use Ecto.Schema

  import Ecto.Changeset
  import BrDocs.Changeset

  schema "users" do
    field :name
    field :brazilian_doc
  end

  def changeset(user, params \\\\ %{}) do
    user
    |> cast(params, [:name, :brazilian_doc])
    |> validate_required([:name, :brazilian_doc])
    |> validate_doc(:brazilian_doc, :cpf)
    |> unique_constraint(:brazilian_doc)
  end
end
```

## Contributing

Before opening a pull request, please open an issue first.

    $ git clone https://github.com/emaiax/brdocs.git
    $ cd brdocs
    $ mix deps.get
    $ mix format --check-formatted
    $ mix credo --strict
    $ mix test

Once you've made your additions and everything passes, go ahead and open a PR!
