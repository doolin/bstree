# Simple binary search tree in python

Python isn't my native language, so implementing a binary search tree seems like an excellent way to get more familiar with Python syntax.

The programming style is best understood as "Ruby in Python." That is, when the python implementation was first written, the author was programming Ruby professionally, and that shows in the implementation.

## Installing Python

There are numerous ways of installing Python. Since this project is currently being developed on OSX, the main contenders are:

1. Home brew
2. pyenv
3. pipenv
4. asdf

Installing from source is always an option, but while interesting it's too distracting.

For this project, Python versioning will be managed using `brew`.

## Pipfile and pipenv

This project uses `pipenv` for environment management.

### Installing pipenv

For this project, `brew` is used:

- `brew install pipenv`

This should result in `pipenv` being available and linked like so:

```sh
$ which pipenv
/usr/local/bin/pipenv
05:19:45 doolin@inventium-2:~/src/bstree/python (git:BST-144*:83c0814)  ruby-2.7.2
$ ls -la /usr/local/bin/pipenv
lrwxr-xr-x 37 doolin  4 Jun 05:19 /usr/local/bin/pipenv -> ../Cellar/pipenv/2021.5.29/bin/pipenv
05:19:57 doolin@inventium-2:~/src/bstree/python (git:BST-144*:83c0814)  ruby-2.7.2
$
```

Check to see where everything is located:

```sh
$ pipenv run python
Python 3.9.5 (default, May  4 2021, 03:36:27)
[Clang 12.0.0 (clang-1200.0.32.29)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> import sys
>>> sys.prefix
'/Users/doolin/.local/share/virtualenvs/python-njCg2GV5'
>>> import site
>>> site.getsitepackages()
['/Users/doolin/.local/share/virtualenvs/python-njCg2GV5/lib/python3.9/site-packages']
>>>
```

## Updating packages

The tooling for selectively updating seems a bit unintuitive, but here's one way to do it:

- Find the outdated packages with `pipenv run pip list -o`
- [Update the desired package with](https://pipenv.kennethreitz.org/en/latest/basics/#example-pipenv-upgrade-workflow) `pipenv update <pkgname>`. This actually works! After years and years of bug reports, it finally works.

It's probably a good idea to check the state of `Pipfile` and `Pipfile.lock` with `git diff` to ensure everything worked out as desired.

## Running tests

- ` pipenv run pytest`

## Code coverage

- `pipenv run coverage html`

## To do

- Clean up the conditional code in the Node class, make it more
  idiomatic Python.
- Use the python disassembler to see how it works.
- Better unit test output with [pytest
  clarity](https://darrenburns.net/posts/pytest-clarity-notes/).
