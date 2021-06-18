# Binary search tree in Lua

An exercise to learn more about Lua programming with my current
favorite data structure.

## Setting up

The code is current operated using `Luarocks`, which can be installed with home brew on MacOs:

- `brew install luarocks`

## Maintenance

The following commands are useful:

- `luarocks list` to see what's installed.
- `luarocks list --outdated` to see which rocks have newer versions.

## Running the tests

The code is executed via the tests, which are run with Luarocks
`busted` tool:

- `luarocks install busted`
- `luarocks install lyaml`
- `busted`

There may be other dependencies, install as needed from `busted` errors.
Luarocks installs to the system by default, it doesn't maintain a local lock file.

For more fun, [invoke an output handler](http://olivinelabs.com/busted/#output-handlers) from
[any of the provided handlers](https://github.com/Olivine-Labs/busted/tree/master/busted/outputHandlers):

- `busted -o TAP`

The size of the test suite could probably be reduced
to some analytically determined necessary and sufficiant size.
