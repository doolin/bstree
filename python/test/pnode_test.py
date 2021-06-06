#!/usr/bin/env python

# pylint: disable=R0201

import unittest
import sys

sys.path.append("../lib")
from pnode import *


class TestPNode(unittest.TestCase):
    def setUp(self):
        self.testing = True

    def test_init(self):
        node = PNode(15)
        assert node.left is None
        assert node.right is None
        assert node.parent is None


if __name__ == "__main__":
    unittest.main()
