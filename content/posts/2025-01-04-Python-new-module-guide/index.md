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

Sure you can use [json](https://docs.python.org/3/library/json.html) for JSON
and [pyyaml](https://pyyaml.org/wiki/PyYAMLDocumentation) for YAML. Then you
have to use untyped dicts for your data.

I've been using [`mashumaro`][mashumaro] and `@dataclass`es instead. Then you
can use type-safe `@dataclass` objects.

[mashumaro]: https://github.com/Fatal1ty/mashumaro

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


# Other topics

- Use a logger and not `print()`
- Use `black`, `isort`, `autoflake` to keep code tidy