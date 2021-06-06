import pdb
from typing import Type


class Node(object):
    def __init__(self, key):
        self.key = key
        self.visited = False
        self.left = None
        self.right = None
        # p is pointer to parent node. The goal of this class is
        # to implement as much as possible without an explicit reference
        # to the parent node. However, some algorithms require the
        # parent node (e.g., clr), so it's defined as a member here to
        # be used for implementations of those algorithms. Hopefully,
        # better algorithms can be derived and the parent pointer
        # elmininated from this class.
        # UPDATE: changing, s/p/parent/ for better readability.
        self.parent = None

    def visit(self):
        self.visited = True

    def is_visited(self):
        return self.visited

    def is_unvisited(self):
        return not self.is_visited()

    def max(self, left, right):
        if left > right:
            return left
        else:
            return right

    def height(self):
        if self.left is not None and self.right is not None:
            return self.max(self.left.height(), self.right.height()) + 1

        if self.left is None and self.right is not None:
            return self.max(0, self.right.height()) + 1

        if self.left is not None and self.right is None:
            return self.max(self.left.height(), 0) + 1

        return 0

    def list_keys(self):
        collector = []
        self.collect(collector)
        return collector

    def collect(self, collector):
        if self.left is None:
            pass
        else:
            self.left.collect(collector)

        collector.append(self.key)

        if self.right is None:
            pass
        else:
            self.right.collect(collector)

    def insert(self, node):
        if node.key < self.key:
            if self.left is None:
                node.parent = self
                self.left = node
            else:
                self.left.insert(node)
        else:
            if self.right is None:
                node.parent = self
                self.right = node
            else:
                self.right.insert(node)

    def search(self, key):
        if self.key == key:
            return self

        if key < self.key:
            if self.left is not None:
                return self.left.search(key)
        else:
            if self.right is not None:
                return self.right.search(key)

    def search_with_parent(self, key, parent=None):
        # print "in search_with_parent, key: %d" % key
        if self.key == key:
            return self, parent

        if key < self.key:
            if self.left is not None:
                return self.left.search_with_parent(key, self)
        else:
            if self.right is not None:
                return self.right.search_with_parent(key, self)

    def is_present(self, key):
        if self.key == key:
            return True

        if key < self.key:
            if self.left is not None:
                return self.left.is_present(key)
        else:
            if self.right is not None:
                return self.right.is_present(key)

    def compute_size(self):
        def get_size(size):
            size += 1
            if self.left is not None:
                gs = self.left.compute_size()
                size = gs(size)
            if self.right is not None:
                gs = self.right.compute_size()
                size = gs(size)
            return size

        return get_size

    def size(self):
        cs = self.compute_size()
        return cs(0)

    def get_successor(self, node, parent, successor):
        if parent.left is not None:
            if parent.left.key == self.key:
                successor = parent

        if node.key == self.key:
            if node.right is not None:
                return node.right.minimum()
            else:
                return successor

        if node.key < self.key:
            if self.left is not None:
                return self.left.get_successor(node, self, successor)
        else:
            if self.right is not None:
                return self.right.get_successor(node, self, successor)

    def successor(self, node):
        return self.get_successor(node, self, node)

    def get_predecessor(self, node, parent, predecessor):
        if parent.right is not None:
            if parent.right.key == self.key:
                predecessor = parent

        if node.key == self.key:
            if node.left is not None:
                return node.left.maximum()
            else:
                return predecessor

        if node.key < self.key:
            if self.left is not None:
                return self.left.get_predecessor(node, self, predecessor)
        else:
            if self.right is not None:
                return self.right.get_predecessor(node, self, predecessor)

    def predecessor(self, node):
        return self.get_predecessor(node, self, node)

    # TODO: refactor this to work with a generic in_order_traverse
    def is_bst(self, minimum=-1000, result=True):
        if self.left is not None:
            result = self.left.is_bst(minimum, result)

        if minimum >= self.key:
            result = False
            return result

        minimum = self.key

        if self.right is not None:
            result = self.right.is_bst(minimum, result)

        return result

    # algorithm originally taken from CLR p. 253
    # parent pointers are part of CLR's definition of
    # node in BST.
    def clr_delete(T, node):
        z, p = T.root.search_with_parent(node)

        if z.left is None or z.right is None:
            y = z
        else:
            y = z.successor(z)

        if y.left is not None:
            x = y.left
        else:
            x = y.right

        if x is not None:
            x.p = y.p  # p is link to parent node

        if y.p is None:
            T.root = x
        else:
            if y == y.p.left:
                y.p.left = x
            else:
                y.p.right = x

        if y != z:
            z.key = y.key

        return y

    def maximum(self):
        if self.right is None:
            return self
        else:
            return self.right.maximum()

    def minimum(self):
        if self.left is None:
            return self
        else:
            return self.left.minimum()

    @classmethod
    def from_dict(cls, tree_dict) -> Type["Node"]:
        """
        Build a (sub)tree recursively from a dict.

        The recursion proceeds in pre-order traverse, as each
        node will have a key, but may not have any children. This
        function will filter out unecessary keys in the dict.

        Note: there are no checks for dict correctness, the binary
        search tree structure is assumed to be correct within the dict.

        TODO:
            1. Ensure type hinting for the return value is correct.
            2. Add type hinting to the tree_dict argument.
            3. Improve the structure of the testing.
            4. Consider moving this to its own file or function.

        Parameters:
            cls: per @classmethod convention
            tree_dict: a correctly structured binary search tree

        Returns:
            Node: at the conclusion of the recursion, the returned node
            will represent the root of the tree as defined by the dict
            which was passed as an argument.
        """
        if tree_dict is None:
            return None

        if not tree_dict:
            return None

        node = Node(tree_dict["key"])

        if tree_dict["left"] is not None:
            node.left = cls.from_dict(tree_dict["left"])

        if tree_dict["right"] is not None:
            node.right = cls.from_dict(tree_dict["right"])

        return node
