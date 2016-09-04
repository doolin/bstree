# Binary search trees

This little repo is part of an ongoing project to compare
how binary search trees are implemented in various languages.
The goal is twofold:

1. Acquire an intuitive sense for how binary trees work.
2. Investigate a range of engineering techniques for implementing
   binary trees.


## TODO

* change `find` to `search` where applicable
* change `add` to `insert` where applicable
* handle nodes with duplicate values. Currently, inserting a duplicate
  node cause a stack overflow. I hope this can be done elegantly, I
  suspect it will look ugly.

* Finish `size`, `search`, `present?`, `height`, `bst?`, `maximum`, `minimum`, `successor` and
  `predecessor` before finishing node `delete`. This will provide a lot
of extra sanity checking for the `delete` implementation.

* Develop some sort of plan for reducing tests to minimal size. There
  should be some analysis or proof techniques for determining the
  necessary and sufficient conditions for testing recursive code. I
  don't mind overtesting while learning, it helps build intuitive
  understanding. But writing too many tests is time I'd rather spend
  learning more theory or actual implementation.

## Specification

The `Tree` data structure API:

* `add` provisions the tree.
* `find` returns a reference to a particular node in the tree.
* `collect` prints values in order to some container or stream.
* `is_present` determines whether a key exists in the tree.
* `depth`
* `destroy` (c/c++) cleans up memory.


## Fun things to do

Here is a list of various exercises and questions pulled from books and
web pages.

* Laakman asks (Ex. 4.7, p. 86) how to find the first common ancestor for
two nodes in a binary tree, which is not necessarily a binary search
tree. (Binary search tree is probably much easier than an arbitrary
binary tree.)


## Current implementations

The following tables show what has been finished, and what is planned
for future implementation.

## Recursive implementation

Binary trees lend themselves particularly well to recursive
implementations for most algorithms.

### Basic functionality

This table was after the beginning of the project, hence some
entries simply show "Done" instead of the date completed. Each feature is
regarded as complete when its associated test passes.

|               | insert     | collect    | dfs        | present?   | height     | delete     | maximum    | minimum    |
|---------------|------------|------------|------------|------------|------------|------------|------------|------------|
| Ruby          | Done       | Done       | Done       | 2016-07-17 | Done       | 2016-07-30 | 2016-07-05 | 2016-07-05 |
| Ruby (module) | 2016-06-27 | 2016-06-27 | 2016-06-27 | 2016-07-01 | 2016-08-01 | 2016-07-30 | 2016-06-28 | 2016-06-28 |
| Python        | Done       | Done       | 2016-06-27 | 2016-07-25 | 2016-07-22 |            | 2016-07-17 | 2016-07-17 |
| Java          | 2016-07-26 | 2016-08-18 | 2016-08-21 | 2016-08-21 | 2016-08-25 |            | 2016-08-21 | 2016-08-21 |
| C++           | Done       | Done       | Done       | 2016-07-27 | 2016-08-28 |            | 2016-07-26 | 2016-07-26 |
| C             | 2016-08-13 | 2016-08-20 | 2016-08-21 | 2016-08-22 | 2016-08-28 |            | 2016-08-24 | 2016-08-24 |
| Lua           | 2016-07-30 | 2016-08-06 | 2016-08-22 | 2016-08-22 | 2016-08-27 |            | 2016-08-24 | 2016-08-24 |
| Javascript    | 2016-08-20 | 2016-08-21 | 2016-08-23 | 2-16-08-23 | 2016-08-27 |            | 2016-08-26 | 2016-08-26 |
| SQL           |            | 2016-08-05 | 2016-07-27 | 2016-07-27 |            |            | 2016-07-28 | 2016-07-28 |


(Table generated by [markdown table generator](http://www.tablesgenerator.com/markdown_tables)).

Note that all the implementations in the table are recursive. Each method could
be written iteratively as well, which is a good exercise for the future.

### Tree properties

|               | full?      | perfect? | complete? | balanced?  | bst?       | size       | successor  | predecessor |
|---------------|------------|----------|-----------|------------|------------|------------|------------|-------------|
| Ruby          | 2016-07-17 |          |           |            | 2016-07-25 | Done       | 2016-08-29 |             |
| Ruby (module) |            |          |           |            | 2016-07-23 | 2016-07-23 | 2016-09-02 |             |
| Python        |            |          |           |            |            | 2016-08-10 | 2016-09-03 |             |
| Java          |            |          |           |            |            | 2016-08-25 | 2016-09-03 |             |
| C++           |            |          |           |            |            | 2016-08-27 | 2016-09-03 |             |
| C             |            |          |           |            |            | 2016-08-13 | 2016-09-04 |             |
| Lua           |            |          |           |            |            | 2016-08-27 |            |             |
| Javascript    |            |          |           |            |            | 2016-08-26 |            |             |
| SQL           |            |          |           |            |            | 2016-08-27 |            |             |


### Persistence, serialization, etc.

|               | json       | relational | yaml       | ==     | ===  | destroy    | common parent |
|---            |---         |---         |---         |---     |---   |---         |---            |
| Ruby          | 2016-07-23 |            |            |        |      |            | 2016-08-04    |
| Ruby (module) |            |            |            |        |      | 2016-08-20 |
| Python        |            |            |            |        |      |            |
| Java          |            |            |            |        |      |            |
| C++           |            |            |            |        |      |            |
| C             |            |            |            |        |      | 2016-08-13 |
| Lua           |            |            |            |        |      |            |
| Javascript    |            |            |            |        |      |            |
| SQL           |            | N/A        |            |        |      |            |


Note: `destroy` for C and C++ means the tree and all the nodes are
shredded and free'd. (TODO) For the scripting languages and Java, `destroy`
performs a post-order traversal, setting all the child pointers to
`NULL`, `nil`, `null` or whatever flavor necessary.

#### AVL-specific functionality

Implementing these various trees is an interesting engineering problem.
The initial approach is to inherit from the binary search tree
implementation, adding and overriding as necessary.

|               | rotations  |
|---            |---         |
| Ruby          | 2016-07-31 |
| Ruby (module) |            |
| Python        |            |
| Java          |            |
| C++           |            |
| C             |            |
| Lua           |            |
| Javascript    |            |
| SQL           |            |


## Iterative implementation

Anything which can be done with recursion can be done with iteration.

Algorithms such as breadth-first search are easier to implement by
iteration.

## Trees implemented with arrays instead of pointers

A gold mine of interesting code awaits implementation.

## Notes

The discerning programmer may find much of the code here to be somewhat
over-tested. This is mostly because I use the testing to examine the
behavior of the implementation, and deepen my understanding of the data
structure, rather than proving the implementation with necessary and
sufficient testing. Writing necessary and sufficient tests is an
excellent exercise, and a good way to get even deeper understanding.
