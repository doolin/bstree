import json
from node import *


class Tree(object):
    def __init__(self, node):
        self.root = node

    def is_empty(self):
        return bool(self.root is None)

    def insert(self, node):
        self.root.insert(node)

    def search(self, value):
        return self.root.search(value)

    def is_present(self, value):
        return self.root.is_present(value)

    def list_keys(self):
        if self.root is None:
            return []
        else:
            return self.root.list_keys()

    def collect(self, collector):
        self.root.collect(collector)

    def size(self):
        if self.root is None:
            return 0
        return self.root.size()

    def maximum(self):
        return self.root.maximum()

    def minimum(self):
        return self.root.minimum()

    def is_bst(self):
        return self.root.is_bst()

    def height(self):
        if self.root is None:
            return 0
        return self.root.height()

    def successor(self, node):
        return self.root.successor(node)

    def predecessor(self, node):
        return self.root.predecessor(node)

    # A better name for `transplant` might be `reset_parent`
    def transplant(self, u, v):
        if u.parent is None:
            self.root = v
        elif u == u.parent.left:
            u.parent.left = v
        else:
            u.parent.right = v

        if v is not None:
            v.parent = u.parent

    def clrs_delete(self, key):
        z = self.search(key)

        if z.left is None:
            self.transplant(z, z.right)
        elif z.right is None:
            self.transplant(z, z.left)
        else:
            y = z.right.minimum()
            if y.parent != z:
                self.transplant(y, y.right)
                y.right = z.right
                y.right.parent = y

            self.transplant(z, y)
            y.left = z.left
            y.left.parent = y

    # Refactored and renamed from CLR. The CLR code is a little
    # difficult to follow as it has a lot of conditional statements
    # and single letter temporary nodes (x, y, z).
    def clr_delete(self, node):
        # for sanity checking as delete method is refactored
        # return self.clr_delete_original(node)

        # z = self.root.find(node.key)

        z = node

        if z.left and z.right:
            node_to_delete = self.root.successor(z)
            # This is where to swap the nodes
            z.key = node_to_delete.key
        else:
            node_to_delete = z

        if node_to_delete.left:
            x = node_to_delete.left
        else:
            x = node_to_delete.right

        if x:
            # TODO: This line works with x.p, needs to be better tested
            # Try deleting x or x.p sucessively to figure out exactly
            # how it works.
            # x.p = node_to_delete.parent
            x.parent = node_to_delete.parent

        if node_to_delete.parent:
            if node_to_delete == node_to_delete.parent.left:
                node_to_delete.parent.left = x
            else:
                node_to_delete.parent.right = x
        else:
            self.root = x

        return node_to_delete

    # algorithm originally taken from CLR p. 253
    # parent pointers are part of CLR's definition of
    # node in BST. The names have been mostly kept the
    # same, however, 'parent' is used instead of 'p' for
    # better readability in refactored delete implementation.
    def clr_delete_original(T, z):
        if z.left is None or z.right is None:
            y = z
        else:
            y = T.root.successor(z)

        if y.left:
            x = y.left
        else:
            x = y.right

        if x is not None:
            x.parent = y.parent

        if y.parent is None:
            T.root = x
        else:
            if y == y.parent.left:
                y.parent.left = x
            else:
                y.parent.right = x

        if y != z:
            z.key = y.key

        return y

    def to_json(self):
        return True
        # print json.dumps(['foo', {'bar': ('baz', None, 1.0, 2)}])
