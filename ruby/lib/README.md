# Implementation

README driven development.

Some initial thoughts on implementation, which may get deleted later, or moved to the `doc` directory.

## AVL tree

AVL trees are a bit harder to implement than a regular binary search tree for at least the following reasons:

1. There is simply more code, which means more can go wrong, and more tests need to be written.
2. It's not clear from the literature how the tree and nodes should be containerized, and how operations on the tree should proceed. For example, should insert and balancing be handled by the container (Tree), or should the balancing be handled as part of an explicit Node insertion?
