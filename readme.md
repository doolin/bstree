# Binary search trees

This little repo is part of an ongoing project to compare
how data structures are implemented in various languages.


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

## Basic functionality

This table was created well after the beginning of the project, hence some
entries simply show "Done" instead of the date completed. Each feature is
regarded as complete when its associated test passes.

|               | add        | collect    | find       | present?   | depth      | destroy | maximum    | minimum    |
|---            |---         |---         |---         |---         |---         |---      |---         |---         |
| Ruby          | Done       | Done       | Done       | 2016-07-17 | Done       |  N/A    | 2016-07-05 | 2016-07-05 |
| Ruby (module) | 2016-06-27 | 2016-06-27 | 2016-06-27 | 2016-07-01 |            |  N/A    | 2016-06-28 | 2016-06-28 |
| Python        | Done       | Done       | 2016-06-27 |            | 2016-07-22 |  N/A    | 2016-07-17 | 2016-07-17 |
| Java          |            |            |            |            |            |  N/A    |            |            |
| C++           | Done       | Done       | Done       |            |            |         |            |            |
| C             |            |            |            |            |            |         |            |            |
| Lua           |            |            |            |            |            |  N/A    |            |            |
| Javascript    |            |            |            |            |            |  N/A    |            |            |
| SQL           |            |            |            |            |            |  N/A    |            |            |


(Table generated by [markdown table generator](http://www.tablesgenerator.com/markdown_tables)).

Note that all the implementations in the table are recursive. Each method could
be written iteratively as well, which is a good exercise for the future.

### Tree properties

|               | full?      | perfect? | complete? | balanced? | bst?       | size       |
|---------------|-------     |----------|-----------|-----------|---         |---         |
| Ruby          | 2016-07-17 |          |           |           |            | Done       |
| Ruby (module) |            |          |           |           | 2016-07-23 | 2016-07-23
| Python        |            |          |           |           |            |
| Java          |            |          |           |           |            |
| C++           |            |          |           |           |            |
| C             |            |          |           |           |            |
| Lua           |            |          |           |           |            |
| Javascript    |            |          |           |           |            |


### Persistence and serialization

|               | json       | relational | yaml       | ==     | ===  |
|---            |---         |---         |---         |---     |---   |
| Ruby          | 2016-07-23 |            |            |        |      |
| Ruby (module) |            |            |            |        |      |
| Python        |            |            |            |        |      |
| Java          |            |            |            |        |      |
| C++           |            |            |            |        |      |
| C             |            |            |            |        |      |
| Lua           |            |            |            |        |      |
| Javascript    |            |            |            |        |      |

## Notes

The discerning programmer may find much of the code here to be
over-tested, possibly massively over-tested. This is mostly because I
use the testing to examine the behavior of the implementation, and
deepen my understanding of the data structure, rather than proving
the implementation with necessary and sufficient testing. Writing
necessary and sufficient tests is an excellent exercise, and a good way
to get even deeper understanding.
