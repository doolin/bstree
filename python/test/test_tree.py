#!/usr/bin/env python

import unittest
import sys
sys.path.append('../lib')
from tree import *
from node import *

class TestTree(unittest.TestCase):

    def setUp(self):
        # dummy
        self.testing = True

    def test_init(self):
        node = Node(2)
        tree = Tree(node)
        assert tree.root == node

    def test_add(self):
        node = Node(8)
        tree = Tree(node)
        node_l1 = Node(4)
        tree.add(node_l1)
        assert tree.root.left == node_l1

    def test_collect(self):
        node = Node(8)
        tree = Tree(node)
        node_l1 = Node(4)
        tree.add(node_l1)
        # Bound method results
        # assert [], tree.collect
        # http://stackoverflow.com/questions/28879886/python-beginner-where-comes-bound-method-of-object-at-0x0000000005ea
        collector = []
        tree.collect(collector)
        assert [4, 8] == collector

    def test_find(self):
        root = Node(15)
        tree = Tree(root)
        node_l1 = Node(8)
        node_l2 = Node(33)
        node_l3 = Node(25)
        node_l4 = Node(4)
        node_l5 = Node(9)
        tree.add(node_l1)
        tree.add(node_l2)
        tree.add(node_l3)
        tree.add(node_l4)
        tree.add(node_l5)
        assert tree.find(33) == node_l2
        assert tree.find(35) is None

    def test_is_present(self):
        node = Node(15)
        tree = Tree(node)
        node_l1 = Node(8)
        node_l2 = Node(33)
        node_l3 = Node(25)
        node_l4 = Node(4)
        node_l5 = Node(9)
        tree.add(node_l1)
        tree.add(node_l2)
        tree.add(node_l3)
        tree.add(node_l4)
        tree.add(node_l5)
        assert node.is_present(33) is True
        assert node.is_present(34) is None

    def test_height_and_size(self):
        node = Node(8)
        tree = Tree(node)
        assert tree.height() == 1
        # assert tree.size() == 1

        node_l1 = Node(4)
        tree.add(node_l1)
        assert tree.height() == 2
        # assert tree.size() == 2

        node_r1 = Node(12)
        tree.add(node_r1)
        assert tree.height() == 2
        # assert tree.size() == 3

        node_l2 = Node(2)
        tree.add(node_l2)
        assert tree.height() == 3
        # assert tree.size() == 4

        node_l3 = Node(1)
        tree.add(node_l3)
        assert tree.height() == 4
        # assert tree.size() == 5

        node_r3 = Node(3)
        tree.add(node_r3)
        assert tree.height() == 4
        # assert tree.size() == 6

    def tearDown(self):
        # dummy
        self.testing = False

if __name__ == '__main__':
    unittest.main()
