#!/usr/bin/env python

import unittest
import sys

sys.path.append("../lib")
from tree import *
from node import *


class TestTree(unittest.TestCase):
    def setUp(self):
        self.testing = True

    def test_init(self):
        node = Node(2)
        tree = Tree(node)
        assert tree.root == node

    def test_is_empty(self):
        root = Node(17)
        tree = Tree(root)
        tree.root = None
        assert tree.is_empty()

    def test_insert(self):
        root = Node(17)
        tree = Tree(root)
        n5 = Node(5)
        tree.insert(n5)
        assert tree.root.left == n5
        assert tree.root.left == n5
        assert tree.root.right is None

    def test_list_keys(self):
        root = Node(17)
        tree = Tree(root)
        assert tree.list_keys() == [17]

    def test_collect(self):
        node = Node(8)
        tree = Tree(node)
        node_l1 = Node(4)
        tree.insert(node_l1)
        # Bound method results
        # assert [], tree.collect
        # http://stackoverflow.com/questions/28879886/python-beginner-where-comes-bound-method-of-object-at-0x0000000005ea
        collector = []
        tree.collect(collector)
        assert [4, 8] == collector

    def test_search(self):
        root = Node(15)
        tree = Tree(root)
        node_l1 = Node(8)
        node_l2 = Node(33)
        node_l3 = Node(25)
        node_l4 = Node(4)
        node_l5 = Node(9)
        tree.insert(node_l1)
        tree.insert(node_l2)
        tree.insert(node_l3)
        tree.insert(node_l4)
        tree.insert(node_l5)
        assert tree.search(33) == node_l2
        assert tree.search(35) is None

    def test_is_present(self):
        node = Node(15)
        tree = Tree(node)
        node_l1 = Node(8)
        node_l2 = Node(33)
        node_l3 = Node(25)
        node_l4 = Node(4)
        node_l5 = Node(9)
        tree.insert(node_l1)
        tree.insert(node_l2)
        tree.insert(node_l3)
        tree.insert(node_l4)
        tree.insert(node_l5)
        assert node.is_present(33) is True
        assert node.is_present(34) is None

    def test_height(self):
        root = Node(17)
        tree = Tree(root)
        assert tree.height() == 0

    def test_size(self):
        root = Node(8)
        tree = Tree(root)
        assert tree.size() == 1

        node_l1 = Node(4)
        tree.insert(node_l1)
        assert tree.size() == 2

        node_r1 = Node(12)
        tree.insert(node_r1)
        assert tree.size() == 3

        node_l2 = Node(2)
        tree.insert(node_l2)
        assert tree.size() == 4

        node_l3 = Node(1)
        tree.insert(node_l3)
        assert tree.size() == 5

        node_r3 = Node(3)
        tree.insert(node_r3)
        assert tree.size() == 6

    def test_maximum_and_minimum(self):
        root = Node(15)
        tree = Tree(root)
        assert tree.maximum() == root
        assert tree.minimum() == root

        node_l1 = Node(8)
        tree.insert(node_l1)
        assert tree.maximum() == root
        assert tree.minimum() == node_l1

        node_l2 = Node(33)
        node_l3 = Node(25)
        tree.insert(node_l2)
        tree.insert(node_l3)
        assert root.maximum() == node_l2
        assert root.minimum() == node_l1

        node_l4 = Node(4)
        node_l5 = Node(9)
        tree.insert(node_l4)
        tree.insert(node_l5)
        assert root.maximum() == node_l2
        assert root.minimum() == node_l4

    def test_is_bst(self):
        root = Node(17)
        tree = Tree(root)
        assert tree.is_bst() == True

    def test_successor_and_predecessor(self):
        root = Node(17)
        tree = Tree(root)
        assert tree.successor(root) == root
        assert tree.predecessor(root) == root

    # TODO:
    #   1. Move all this to its own file.
    #   2. Parameterize the tests into smaller units
    def test_from_yaml(self):
        tree = Tree.from_yaml("../fixtures/tree1.yml")
        assert tree.size() == 1
        assert tree.height() == 0
        assert tree.is_bst() == True
        # assert tree.is_full() == True # BST-168
        # assert tree.is_balanced() == True # BST-169
        # assert tree.post_order_keys() == [11] # BST-170
        # assert tree.pre_order_keys() == [11] # BST-171
        # assert tree.is_degenerate() == False # BST-172

        tree = Tree.from_yaml("../fixtures/tree2.yml")
        assert tree.size() == 2
        assert tree.height() == 1
        assert tree.is_bst() == True
        # assert tree.is_full() == False
        # assert tree.is_balanced() == True
        # assert tree.post_order_keys() == [7, 11]
        # assert tree.pre_order_keys() == [11, 7]
        # assert tree.is_degenerate() == False

        tree = Tree.from_yaml("../fixtures/tree3.yml")
        assert tree.size() == 3
        assert tree.height() == 1
        assert tree.is_bst() == True
        # assert tree.is_full() == True
        # assert tree.is_balanced() == True
        # assert tree.post_order_keys() == [7, 13, 11]
        # assert tree.pre_order_keys() == [11, 7, 13]
        # assert tree.is_degenerate() == False

        tree = Tree.from_yaml("../fixtures/tree4.yml")
        assert tree.size() == 4
        assert tree.height() == 2
        assert tree.is_bst() == True
        # assert tree.is_full() == False
        # assert tree.is_balanced() == True
        # assert tree.post_order_keys() == [3, 7, 13, 11]
        # assert tree.pre_order_keys() == [11, 7, 3, 13]
        # assert tree.is_degenerate() == False

        tree = Tree.from_yaml("../fixtures/tree5.yml")
        assert tree.size() == 5
        assert tree.height() == 2
        assert tree.is_bst() == True
        # assert tree.is_full() == False
        # assert tree.is_balanced() == True
        # assert tree.post_order_keys() == [3, 7, 19, 13, 11]
        # assert tree.pre_order_keys() == [11, 7, 3, 13, 19]
        # assert tree.is_degenerate() == True

        tree = Tree.from_yaml("../fixtures/tree6.yml")
        assert tree.size() == 6
        assert tree.height() == 3
        assert tree.is_bst() == True
        # assert tree.is_full() == False
        # assert tree.is_balanced() == False
        # assert tree.post_order_keys() == [3, 7, 29, 19, 13, 11]
        # assert tree.pre_order_keys() == [11, 7, 3, 13, 19, 29]
        # assert tree.is_degenerate() == True

        tree = Tree.from_yaml("../fixtures/tree7.yml")
        assert tree.size() == 7
        assert tree.height() == 3
        assert tree.is_bst() == True
        # assert tree.is_full() == False
        # assert tree.is_balanced() == False
        # assert tree.post_order_keys() == [5, 3, 7, 29, 19, 13, 11]
        # assert tree.pre_order_keys() == [11, 7, 3, 5, 13, 19, 29]
        # assert tree.is_degenerate() == True

        tree = Tree.from_yaml("../fixtures/tree8.yml")
        assert tree.size() == 8
        assert tree.height() == 3
        assert tree.is_bst() == True
        # assert tree.is_full() == False
        # assert tree.is_balanced() == False
        # assert tree.post_order_keys() == [2, 5, 3, 7, 29, 19, 13, 11]
        # assert tree.pre_order_keys() == [11, 7, 3, 2, 5, 13, 19, 29]
        # assert tree.is_degenerate() == True

        tree = Tree.from_yaml("../fixtures/tree9.yml")
        assert tree.size() == 9
        assert tree.height() == 3
        assert tree.is_bst() == True
        # assert tree.is_full() == False
        # assert tree.is_balanced() == False
        # assert tree.post_order_keys() == [2, 5, 3, 7, 17, 29, 19, 13, 11]
        # assert tree.pre_order_keys() == [11, 7, 3, 2, 5, 13, 19, 17, 29]
        # assert tree.is_degenerate() == True

        tree = Tree.from_yaml("../fixtures/tree10.yml")
        assert tree.size() == 10
        assert tree.height() == 4
        assert tree.is_bst() == True
        # assert tree.is_full() == False
        # assert tree.is_balanced() == False
        # assert tree.post_order_keys() == [2, 5, 3, 7, 17, 23, 29, 19, 13, 11]
        # assert tree.pre_order_keys() == [11, 7, 3, 2, 5, 13, 19, 17, 29, 23]
        # assert tree.is_degenerate() == True

    def tearDown(self):
        # dummy
        self.testing = False


if __name__ == "__main__":
    unittest.main()
