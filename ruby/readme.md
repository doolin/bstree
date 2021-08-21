# Simple binary search tree in Ruby

This tiny little project came about as a result of a conversation
with a coworker, a self-taught programmer with a background in
Russian literature. We both agreed we needed to step it up a bit,
and binary search trees seemed like an excellent place to start.

## Finding a node

In a really simple case, the node key and value can be the same.
For example, any atomic (<- is the right word?) object such as
an integer or character, which can be ordered can be used as a
key.

One way to implement find is to have all the operations for find
as part of the node class, then pass the key to the root node
from the tree data structure. This is what is implemented here,
and works similarly to the `add` method.

Another possibility is to implement the traversal in the tree
class.

## Trees recursive and iterative

Recursive techniques usually feel a lot more natural once
a programmer has a certain amount of experience, and is the
go-to technique for operations on recursively defined structures
such as binary trees. Accordingly, the most complete implemenation
will be recursive.

However, iteration is always viable, and may save stack, and increase
speed, so a number of algorithms are also implemented recursively.

To keep lower the confusion, the `Tree`, `Node` and related
data structures will all be implemented with recursive
algorithms. Iterative implementations will subclass the
recursive, overriding with iteration as necessary. The
naming pattern for these subclasses will follow the pattern
`IterativeTree`, `IterativeNode`, and so on.

## Make trees super fast

The `Generator` class can be used to make trees really fast. Here's an example:

1. `cd ruby`
1. `irb`
1. `require_relative './lib/generator'`
1. `tree = Generator.build([7, 5, 13, 11, 15], "uuid")`
1. `tree.to_yaml_file('../fixtures/full/tree5.yml')`

This creates a full binary search tree and writes it to a yaml file.

## TODO

- Create a simple data structure to store, subclass `Struct`
- Add `node.key` and use value for some associated data object
- (DONE) Test for node not present in a tree.
- Refactor the comparator specs in `node_spec.rb`

## References

- [Wikipedia](https://en.wikipedia.org/wiki/Binary_search_tree), because
  there's no shame in simply getting started however which way, and
  Wikipedia is free for everyone.
- [CLR](https://www.amazon.com/Introduction-Algorithms-3rd-MIT-Press/dp/0262033844/) Gold standard.
- [Skienna](https://www.amazon.com/Algorithm-Design-Manual-Steven-Skiena/dp/B00B8139Z8/),
  a very useful reference with readable exposition and a unique slant.
