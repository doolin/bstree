#!/usr/bin/env python

# pylint: disable=R0201

import unittest
import sys
import os
dir = os.path.dirname(__file__)
libpath = os.path.join(dir, '..', 'lib')
sys.path.append(libpath)

from node import *

class TestNode(unittest.TestCase):

    def setUp(self):
        # dummy
        self.testing = True

    def test_init(self):
        node = Node(15)
        assert node.left is None
        assert node.right is None
        assert node.is_visited() is False

    def test_is_visited(self):
        node = Node(17)
        assert node.is_visited() is False
        node.visit()
        assert node.is_visited() is True

    def test_is_unvisited(self):
        node = Node(17)
        assert node.is_unvisited() is True
        node.visit()
        assert node.is_unvisited() is False

    def test_collect(self):
        node = Node(15)
        node_l1 = Node(8)
        node_l2 = Node(33)
        node_l3 = Node(25)
        node_l4 = Node(4)
        node.insert(node_l1)
        node.insert(node_l2)
        node.insert(node_l3)
        node.insert(node_l4)
        collector = []
        node.collect(collector)
        assert collector == [4, 8, 15, 25, 33]

    def list_keys(self):
        root = Node(17)
        assert root.list_keys() == [17]


    def test_insert(self):
        node = Node(15)
        node_l1 = Node(8)
        node_l2 = Node(33)
        node_l3 = Node(25)
        node_l4 = Node(4)
        node_l5 = Node(9)
        node.insert(node_l1)
        node.insert(node_l2)
        node.insert(node_l3)
        node.insert(node_l4)
        node.insert(node_l5)
        assert node.left == node_l1
        assert node.right == node_l2
        assert node.right.left == node_l3
        assert node.left.left == node_l4
        assert node.left.right == node_l5

    def test_search(self):
        root = Node(15)
        node_l1 = Node(8)
        node_l2 = Node(33)
        node_l3 = Node(25)
        node_l4 = Node(4)
        node_l5 = Node(9)
        root.insert(node_l1)
        root.insert(node_l2)
        root.insert(node_l3)
        root.insert(node_l4)
        root.insert(node_l5)
        assert root.search(33) == node_l2
        n, p = root.search_with_parent(8)
        assert n == node_l1
        assert p == root

    def test_is_present(self):
        node = Node(15)
        node_l1 = Node(8)
        node_l2 = Node(33)
        node_l3 = Node(25)
        node_l4 = Node(4)
        node_l5 = Node(9)
        node.insert(node_l1)
        node.insert(node_l2)
        node.insert(node_l3)
        node.insert(node_l4)
        node.insert(node_l5)
        assert node.is_present(33) is True
        assert node.is_present(34) is None

    def test_maximum_and_minimum(self):
        root = Node(15)
        assert root.maximum() == root
        assert root.minimum() == root

        node_l1 = Node(8)
        root.insert(node_l1)
        assert root.maximum() == root
        assert root.minimum() == node_l1

        node_l2 = Node(33)
        node_l3 = Node(25)
        root.insert(node_l2)
        root.insert(node_l3)
        assert root.maximum() == node_l2
        assert root.minimum() == node_l1

        node_l4 = Node(4)
        node_l5 = Node(9)
        root.insert(node_l4)
        root.insert(node_l5)
        assert root.maximum() == node_l2
        assert root.minimum() == node_l4

    def test_is_bst(self):
        root = Node(17)
        assert root.is_bst() is True

        n5 = Node(5)
        root.insert(n5)
        assert root.is_bst() == True

        n23 = Node(23)
        root.insert(n23)
        assert root.is_bst() == True

        n14 = Node(14)
        n23.insert(n14)
        assert n23.is_bst() == True
        assert root.is_bst() == False

    def test_delete(self):
        root = Node(17)
        n5 = Node(5)
        n23 = Node(23)
        root.insert(n5)
        root.insert(n23)
        # result = root.clr_delete(n23)
        # assert result == n23

    def test_height_and_size(self):
        root = Node(8)
        assert root.height() == 0
        assert root.size() == 1

        node_l1 = Node(4)
        root.insert(node_l1)
        assert root.height() == 1
        assert root.size() == 2

        node_r1 = Node(12)
        root.insert(node_r1)
        assert root.height() == 1
        assert root.size() == 3

        node_l2 = Node(2)
        root.insert(node_l2)
        assert root.height() == 2
        assert root.size() == 4
        assert node_l1.size() == 2
        assert node_l2.size() == 1

        node_l3 = Node(1)
        root.insert(node_l3)
        assert root.height() == 3
        assert root.size() == 5

        node_r3 = Node(3)
        root.insert(node_r3)
        assert root.height() == 3
        assert root.size() == 6

    def test_successor_and_predecessor(self):
        root = Node(17)
        n23 = Node(23)
        n2 = Node(2)
        n3 = Node(3)
        n5 = Node(5)
        n7 = Node(7)
        n11 = Node(11)
        n13 = Node(13)
        n19 = Node(19)
        n23 = Node(23)
        n29 = Node(29)
        root.insert(n5)
        root.insert(n23)
        root.insert(n7)
        root.insert(n3)
        root.insert(n2)
        root.insert(n11)
        root.insert(n13)
        root.insert(n29)
        root.insert(n19)
        assert root.successor(n5) == n7
        assert root.predecessor(n7) == n5

        assert root.successor(n7) == n11
        assert root.predecessor(n11) == n7

        assert root.successor(n11) == n13
        assert root.predecessor(n13) == n11

        assert root.successor(n13) == root
        assert root.predecessor(root) == n13

        assert root.successor(root) == n19
        assert root.predecessor(n19) == root

        assert root.successor(n29) == n29
        assert root.predecessor(n29) == n23

        assert root.successor(n19) == n23
        assert root.predecessor(n23) == n19

        assert n23.successor(n23) == n29
        assert n23.predecessor(n23) == n19

        assert root.successor(n3) == n5
        assert root.predecessor(n5) == n3

        assert root.successor(n2) == n3
        assert root.predecessor(n3) == n2
        assert n2.predecessor(n2) == n2

    def tearDown(self):
        self.testing = False

if __name__ == '__main__':
    unittest.main()
