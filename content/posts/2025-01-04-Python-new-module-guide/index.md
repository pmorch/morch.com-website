---
title: 'Python New Module Guide'
date: 2025-01-04T16:01:16+01:00
tags: []
featured_image: 'python.webp'
description: ''
---
# Python new project guide

I've written this mostly as a guide to myself. I'm a little new to python (so
this is the perfect time for me to write this), but not new to programming.

This is not about the python language or syntax, but about the right modules to
use to setup a skeleton project.

This doc came out of painfully learning these things one by one.

# Use `uv`

[`uv`](https://docs.astral.sh/uv/) is an extremely fast Python package and
project manager. It replaces `pip`, `pipx`, `venv`, and most of what you'd use
`hatch` for. Install it following the [official
instructions](https://docs.astral.sh/uv/getting-started/installation/).

## Creating a new project with `uv init --package`

Use `uv init --package my-package` to create a new project:

```shell
$ uv init --package todo
$ cd todo
$ tree
.
├── pyproject.toml
├── README.md
└── src
    └── todo
        └── __init__.py
```

This sets up `pyproject.toml` with hatchling as the build backend and a script
entry point:

```toml
[project.scripts]
todo = "todo:main"

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"
```

Now you can run your package:

```shell
# Run a command in the project's virtual environment
$ uv run python -c 'import todo'

# Run the script entry point
$ uv run todo
```

`uv` automatically creates and manages the `.venv` virtual environment for you.

## Adding dependencies

```shell
# Add a runtime dependency
$ uv add requests

# Add a development dependency
$ uv add --dev pytest ruff
```

## Installing CLI tools globally

Instead of `pipx`, use `uv tool install`:

```shell
$ uv tool install ruff
$ uv tool install httpie
```

This installs tools in isolated environments and makes them available globally.

## Test utilities

The presence of `tests/__init__.py` makes `tests` a module in its own right. So
you can create a `tests/config_reader.py` support utility and then use it from
`tests/mytest.py` as:

```python
from . import config_reader
from todo import some_feature

# use it
config_reader.read(...)
```

This is handy for common functionality across multiple tests.

# Use `xdg_base_dirs` for common directories

Use `xdg_base_dirs` and don't hardcode e.g. `~/.todo/config.yaml`.

* `xdg_config_home()` for config files
* `xdg_cache_home()` for for cache
* `xdg_data_home()` for data
* `xdg_state_home()` for history and logs

E.g.:

```python
from xdg_base_dirs import xdg_config_home

config_file = xdg_config_home() / "polyopen/config.yaml"
```

Then read the config file with [`mashumaro`][mashumaro].

# `rich-argparse` over `argparse `

[argparse](https://docs.python.org/3/library/argparse.html) is great.

Except that I'm wanting a couple of extra features from my `--help` text:

1. I want it to automatically adjust to my terminal width.
2. I want to be able to have separate paragraphs in the help text.
3. I want to show default values.

With vanilla argparse I can get 1. or 2. but not both, and with some hacks I can
get 3. also.

But with [`rich-argparse`](https://github.com/hamdanal/rich-argparse) I can get
[all three](https://github.com/hamdanal/rich-argparse/issues/140):

```python
import argparse
from rich_argparse.contrib import ParagraphRichHelpFormatter
from rich.markdown import Markdown

class MyHelpFormatter(
  argparse.ArgumentDefaultsHelpFormatter,
  ParagraphRichHelpFormatter):
  pass

parser = argparse.ArgumentParser(
    description=Markdown(description, style="argparse.text"),
    formatter_class=MyHelpFormatter,
)

parser.add_argument('--foo', help=foo_help)

args = parser.parse_args()
```

As an added bonus, it looks much nicer than vanilla argparse.

# Consider `mashumaro` for your JSON and YAML needs

Sure you can use [json](https://docs.python.org/3/library/json.html) for JSON and [pyyaml](https://pyyaml.org/wiki/PyYAMLDocumentation) for YAML. Then you have to use untyped dicts for your data.

I've been using [`mashumaro`][mashumaro] and `@dataclass`es instead. Then you can use type-safe `@dataclass` objects.

```python
# Basically, JSON, YAML (and TOML) all work the same way.
import mashumaro.codecs.json as json_codec
import mashumaro.codecs.yaml as yaml_codec
from dataclasses import dataclass

@dataclass
class NestedField:
    bool_field: bool

@dataclass
class SerializeMe:
    string_field: str
    int_field: int
    nested: NestedField

obj = SerializeMe(
    string_field="hello world",
    int_field=42,
    nested=NestedField(bool_field=True)
)

json = json_codec.encode(obj, SerializeMe)

print(json)
# Prints
# {"string_field": "hello world", "int_field": 42, "nested": {"bool_field": true}}

# Recall that JSON is a subset of YAML, so you can load JSON as YAML.
obj = yaml_codec.decode(json, SerializeMe)

print(obj)
# Prints
# SerializeMe(string_field='hello world', int_field=42, nested=NestedField(bool_field=True))
```

[mashumaro]: https://github.com/Fatal1ty/mashumaro

# Other topics

- Use a logger and not `print()`
- Use [`ruff`](https://docs.astral.sh/ruff/) for linting and formatting - it
  replaces `black`, `isort`, `flake8`, `autoflake`, and many others in a single,
  fast tool:
  ```shell
  $ uv add --dev ruff
  $ uv run ruff check --fix  # lint and auto-fix
  $ uv run ruff format       # format code
  ```
