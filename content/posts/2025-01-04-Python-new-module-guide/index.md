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

# Actually, use `uv`

The problem/question is: One problem that keeps coming up is how to use `uv` with a venv other than `.venv`.

## Use `uv init --package my-package`

This sets up `pyproject.toml` with:

```toml
...

[project.scripts]
my-package = "my_package:main"

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"
```
Which then does the equivalent of `uv pip install -e .` and adds `.venv/lib/python3.13/site-packages/_my_package.pth` containing:

```
/path/to/my-package/src
```

So that these two work from any directory:

```shell
# This imports the package "raw"
$ uv run python -c 'import my_package'
# This runs my_package.main() via project.scripts.my-package
$ uv run my-package
```

## `uv` and venvs other than `.venv`

I can create a virtual environment ("venv") other than `.venv` with:

```shell
$ uv init
$ uv venv other-venv
```

What is the intended/canonical way to use `uv` with such an alternate venv?

How can I get `uv add` and `uv sync` to use and update it?

In some cases, `-p other-venv` works, such as here:

```shell
$ uv pip install  -p other-venv numpy
Using Python 3.13.2 environment at other-venv
Resolved 1 package in 3ms
Installed 1 package in 11ms
 + numpy==2.2.6

$ ls -ld other-venv/lib/python3.13/site-packages/numpy
drwxr-xr-x 1 peter peter 1076 May 25 19:06 other-venv/lib/python3.13/site-packages/numpy
```

But it doesn't work here:

```shell
$ uv add -p other-venv pause
Using CPython 3.13.2 interpreter at: other-venv/bin/python3
Creating virtual environment at: .venv
Resolved 2 packages in 32ms
Installed 1 package in 0.42ms
 + pause==0.3

$ ls -ld other-venv/lib/python3.13/site-packages/pause
ls: cannot access 'other-venv/lib/python3.13/site-packages/pause': No such file or directory

$ ls -ld .venv/lib/python3.13/site-packages/pause
drwxr-xr-x 1 peter peter 32 May 25 19:07 .venv/lib/python3.13/site-packages/pause
```

or here:

```shell
$ uv sync -p other-venv
Using CPython 3.13.2 interpreter at: other-venv/bin/python3
Removed virtual environment at: .venv
Creating virtual environment at: .venv
Resolved 2 packages in 0.58ms
Installed 1 package in 0.54ms
 + pause==0.3
```

What does seem to work in every case is:

```shell
$ UV_PROJECT_ENVIRONMENT=other-venv uv sync
Resolved 2 packages in 0.53ms
Uninstalled 1 package in 9ms
Installed 1 package in 0.51ms
 - numpy==2.2.6
 + pause==0.3

$ ls -ld other-venv/lib/python3.13/site-packages/pause
drwxr-xr-x 1 peter peter 32 May 25 19:10 other-venv/lib/python3.13/site-packages/pause
```

# Use `pipx`

`pipx` allows you to install python-based executables without needing root and
without directly using virtual environments (`venv`s). Go ahead and install it
using your standard package manager (e.g. `apt`, `yum, brew` or whatever is
great for your system.

Then add `~/.local/bin` to your path if it isn't already.

# Use `hatch`

Hatchling is the recommended way to package your lib or app. You might as well
get started properly, so install hatch that helps you setup hatch projects.
Hatch is oddly not mentioned in [Packaging Python Projects - Python Packaging
User
Guide](https://packaging.python.org/en/latest/tutorials/packaging-projects/),
but I've found `hatch` to be the [path of least
resistance](https://stackoverflow.com/questions/79232116/) for developing and
setting up `PYTHONPATH`, `venvs` and the like.

I used `pipx install hatch` (from above) to install it.

Use hatch to create the new project boilerplate. I'll be creating my version of
the ubiquitous `todo` project:

```shell
$ hatch new todo ./todo
todo
├── src
│   └── todo
│       ├── __about__.py
│       └── __init__.py
├── tests
│   └── __init__.py
├── LICENSE.txt
├── README.md
└── pyproject.toml
```

It sets up some boilerplate. Go ahead edit the generated files, at least changing your name.

But now the `todo` module has been created for you. You can:

```shell
$ hatch shell
(temp) $ python3 -c 'import todo'
(temp) $ exit
```

and this works too:

```
$ hatch run python3 -c 'import todo'
```

## Test utilities

This took me a while to figure out: The presence of `tests/__init__.py` makes `tests` a module in its own right. So you can create a `tests/config_reader.py` support utility and then use it from `tests/mytest.py` as:

```python
from . import config_reader
from todo import todo_feature

# use it
config.reader.read(whatever)
```

This is handy for common functionality across multiple tests.

# Use `venvs` when not using `hatch`

Don't ever use `sudo pip install whatever`.

`hatch` and `pipx` are your friends. But if I want to try out something in a
temporary environment, I use:

```shell
$ python3 -m venv ./tempdir
$ ./tempdir/bin/pip3 install /path/to/todo
$ ./tempdir/bin/pip3 install some-other-package
$ ./tempdir/bin/python3 ...
```

This allows me to later `rm -rf tempdir` without having polluted my system.

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
- Use `black`, `isort`, `autoflake` to keep code tidy
