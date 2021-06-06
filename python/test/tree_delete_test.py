#!/usr/bin/env python

# pylint: disable=invalid-name,missing-docstring,no-self-use

import pdb

import unittest
import sys

sys.path.append("../lib")
from tree import *
from node import *


class TestTreeDelete(unittest.TestCase):
    def setUp(self):
        self.testing = True

    def test_transplant_root_with_nil(self):
        root = Node(17)
        tree = Tree(root)
        tree.transplant(root, None)
        assert tree.is_empty()

    def test_transplant_left_child(self):
        root = Node(17)
        tree = Tree(root)
        n23 = Node(23)
        tree.insert(n23)
        tree.transplant(root, n23)
        assert tree.root == n23
        assert n23.parent is None

    def test_transplant_right_child(self):
        root = Node(17)
        tree = Tree(root)
        n5 = Node(5)
        tree.insert(n5)
        tree.transplant(root, n5)
        assert tree.root == n5
        assert n5.parent is None

    def test_transplant_right_tree(self):
        root = Node(17)
        tree = Tree(root)
        n23 = Node(23)
        n29 = Node(29)
        tree.insert(n23)
        tree.insert(n29)
        tree.transplant(n23, n29)
        assert n29.parent == root
        assert root.right == n29

    def test_transplant_right_tree_nil(self):
        root = Node(17)
        tree = Tree(root)
        n23 = Node(23)
        tree.insert(n23)
        tree.transplant(n23, None)
        assert root.right is None

    def test_transplant_left_tree(self):
        root = Node(17)
        tree = Tree(root)
        n5 = Node(5)
        n7 = Node(7)
        tree.insert(n5)
        tree.insert(n7)
        tree.transplant(n5, n7)
        assert n7.parent == root
        assert root.left == n7

    def test_transplant_left_tree_nil(self):
        root = Node(17)
        tree = Tree(root)
        n5 = Node(5)
        tree.insert(n5)
        tree.transplant(n5, None)
        assert root.left is None

    def test_delete_root_when_single_node(self):
        root = Node(17)
        tree = Tree(root)
        result = tree.clr_delete(root)
        assert result == root
        assert tree.is_empty()

    def test_delete_left_child_from_two_node_tree(self):
        root = Node(17)
        assert root.right is None
        assert root.left is None
        tree = Tree(root)
        # tree.insert(root) # DON'T DO THIS! See Trac 2587

        n5 = Node(5)
        tree.insert(n5)
        result = tree.clr_delete(n5)
        assert result == n5

        assert tree.root.right is None
        assert tree.root.left is None
        assert tree.height() == 0
        assert tree.size() == 1

    def test_delete_root_with_two_children(self):
        root = Node(17)
        tree = Tree(root)
        n5 = Node(5)
        n23 = Node(23)
        tree.insert(n5)
        tree.insert(n23)
        tree.clr_delete(root)
        assert tree.root.key == 23
        assert tree.root == root
        assert tree.is_bst() is True
        assert tree.list_keys() == [5, 23]
        assert tree.size() == 2

    def test_delete_right_leaf(self):
        root = Node(17)
        tree = Tree(root)
        n5 = Node(5)
        n23 = Node(23)
        tree.insert(n5)
        tree.insert(n23)
        result = tree.clr_delete(n5)
        assert result == n5
        assert tree.size() == 2
        assert tree.is_bst() is True
        assert tree.list_keys() == [17, 23]

    def test_delete_left_leaf(self):
        root = Node(17)
        tree = Tree(root)
        n5 = Node(5)
        n23 = Node(23)
        tree.insert(n5)
        tree.insert(n23)
        result = tree.clr_delete(n23)
        assert result == n23
        assert tree.size() == 2
        assert tree.is_bst() is True
        assert tree.list_keys() == [5, 17]

    def test_delete_minimum(self):
        root = Node(17)
        tree = Tree(root)
        n5 = Node(5)
        n23 = Node(23)
        tree.insert(n5)
        tree.insert(n23)
        n3 = Node(3)
        n2 = Node(2)
        tree.insert(n3)
        tree.insert(n2)
        n7 = Node(7)
        n11 = Node(11)
        n13 = Node(13)
        tree.insert(n7)
        tree.insert(n11)
        tree.insert(n13)
        n19 = Node(19)
        n29 = Node(29)
        tree.insert(n19)
        tree.insert(n29)
        result = tree.clr_delete(n2)
        assert result == n2
        assert tree.size() == 9
        assert tree.is_bst() is True
        assert tree.list_keys() == [3, 5, 7, 11, 13, 17, 19, 23, 29]

    def test_delete_maximum(self):
        root = Node(17)
        tree = Tree(root)
        n5 = Node(5)
        n23 = Node(23)
        tree.insert(n5)
        tree.insert(n23)
        n3 = Node(3)
        n2 = Node(2)
        tree.insert(n3)
        tree.insert(n2)
        n7 = Node(7)
        n11 = Node(11)
        n13 = Node(13)
        tree.insert(n7)
        tree.insert(n11)
        tree.insert(n13)
        n19 = Node(19)
        n29 = Node(29)
        tree.insert(n19)
        tree.insert(n29)
        result = tree.clr_delete(n29)
        assert result == n29
        assert tree.size() == 9
        assert tree.is_bst() is True
        assert tree.list_keys() == [2, 3, 5, 7, 11, 13, 17, 19, 23]

    def test_delete_left_singly_linked(self):
        root = Node(17)
        tree = Tree(root)
        n5 = Node(5)
        n23 = Node(23)
        tree.insert(n5)
        tree.insert(n23)
        n3 = Node(3)
        n2 = Node(2)
        tree.insert(n3)
        tree.insert(n2)
        n7 = Node(7)
        n11 = Node(11)
        n13 = Node(13)
        tree.insert(n7)
        tree.insert(n11)
        tree.insert(n13)
        n19 = Node(19)
        n29 = Node(29)
        tree.insert(n19)
        tree.insert(n29)
        result = tree.clr_delete(n7)
        assert result == n7
        assert tree.size() == 9
        assert tree.is_bst() is True
        assert tree.list_keys() == [2, 3, 5, 11, 13, 17, 19, 23, 29]

    def test_delete_right_internal(self):
        root = Node(17)
        tree = Tree(root)
        n5 = Node(5)
        n23 = Node(23)
        tree.insert(n5)
        tree.insert(n23)
        n3 = Node(3)
        n2 = Node(2)
        tree.insert(n3)
        tree.insert(n2)
        n7 = Node(7)
        n11 = Node(11)
        n13 = Node(13)
        tree.insert(n7)
        tree.insert(n11)
        tree.insert(n13)
        n19 = Node(19)
        n29 = Node(29)
        tree.insert(n19)
        tree.insert(n29)
        result = tree.clr_delete(n23)
        assert result == n29
        assert tree.size() == 9
        assert tree.is_bst() is True
        assert tree.list_keys() == [2, 3, 5, 7, 11, 13, 17, 19, 29]

    def test_delete_left_internal(self):
        root = Node(17)
        tree = Tree(root)
        n5 = Node(5)
        n23 = Node(23)
        tree.insert(n5)
        tree.insert(n23)
        n3 = Node(3)
        n2 = Node(2)
        tree.insert(n3)
        tree.insert(n2)
        n7 = Node(7)
        n11 = Node(11)
        n13 = Node(13)
        tree.insert(n7)
        tree.insert(n11)
        tree.insert(n13)
        n19 = Node(19)
        n29 = Node(29)
        tree.insert(n19)
        tree.insert(n29)
        result = tree.clr_delete(n5)
        assert result == n7
        assert tree.size() == 9
        assert tree.is_bst() is True
        assert tree.list_keys() == [2, 3, 7, 11, 13, 17, 19, 23, 29]

    def test_clrs_delete(self):
        root = Node(17)
        tree = Tree(root)
        n5 = Node(5)
        n23 = Node(23)
        tree.insert(n5)
        tree.insert(n23)
        n3 = Node(3)
        n2 = Node(2)
        tree.insert(n3)
        tree.insert(n2)
        n7 = Node(7)
        n11 = Node(11)
        n13 = Node(13)
        tree.insert(n7)
        tree.insert(n11)
        tree.insert(n13)
        n19 = Node(19)
        n29 = Node(29)
        tree.insert(n19)
        tree.insert(n29)
        assert tree.list_keys() == [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]

        tree.clrs_delete(2)
        assert n3.left is None
        assert tree.size() == 9
        assert tree.list_keys() == [3, 5, 7, 11, 13, 17, 19, 23, 29]

        tree.clrs_delete(5)
        assert tree.size() == 8
        assert tree.root.left == n7
        assert n7.parent == tree.root
        assert n7.left == n3
        assert tree.list_keys() == [3, 7, 11, 13, 17, 19, 23, 29]

        tree.clrs_delete(17)
        assert tree.size() == 7
        assert tree.root == n19
        assert tree.root.left == n7
        assert n7.parent == tree.root
        assert tree.root.right == n23
        assert n23.parent == tree.root
        assert n19.parent is None
        assert tree.list_keys() == [3, 7, 11, 13, 19, 23, 29]

        tree.clrs_delete(13)
        assert tree.size() == 6
        assert n11.right is None
        assert tree.list_keys() == [3, 7, 11, 19, 23, 29]

        tree.clrs_delete(23)
        assert tree.size() == 5
        assert tree.root.right == n29
        assert n29.parent == tree.root
        assert tree.list_keys() == [3, 7, 11, 19, 29]

        tree.clrs_delete(7)
        assert tree.size() == 4
        assert tree.root.left == n11
        assert n11.parent == tree.root
        assert n3.parent == n11
        assert tree.list_keys() == [3, 11, 19, 29]

        tree.clrs_delete(19)
        tree.clrs_delete(11)
        tree.clrs_delete(3)
        assert tree.size() == 1
        assert tree.root == n29
        assert n29.left is None
        assert n29.right is None
        assert tree.list_keys() == [29]

        tree.clrs_delete(29)
        assert tree.is_empty()
        assert tree.size() == 0
        assert tree.list_keys() == []

    def tearDown(self):
        self.testing = False


if __name__ == "__main__":
    unittest.main()
