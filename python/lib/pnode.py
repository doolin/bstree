# pnode is node with parent pointer

import sys

sys.path.append(".")
from node import Node


class PNode(Node):
    def __init__(self, key):
        Node.__init__(self, key)
        self.parent = None
