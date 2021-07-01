const Node = function (k) {
  this.key = k;
  this.left = null;
  this.right = null;
  this.parent = null;
};

Node.prototype.log = function (msg) {
  console.log(msg);
};

// Node.prototype.init = function(k) {
// };

Node.prototype.insert = function (n) {
  if (n.key < this.key) {
    if (this.left === null) {
      n.parent = this;
      this.left = n;
    } else {
      this.left.insert(n);
    }
  } else {
    if (this.right === null) {
      n.parent = this;
      this.right = n;
    } else {
      this.right.insert(n);
    }
  }
};

Node.prototype.maximum = function () {
  if (this.right !== null) {
    return this.right.maximum();
  }
  return this;
};

Node.prototype.minimum = function () {
  if (this.left !== null) {
    return this.left.minimum();
  }
  return this;
};

Node.prototype.search = function (key) {
  if (key === this.key) {
    return this;
  }

  if (key < this.key) {
    if (this.left !== null) {
      return this.left.search(key);
    }
  } else {
    if (this.right !== null) {
      return this.right.search(key);
    }
  }
};

Node.prototype.isPresent = function (key) {
  if (key === this.key) {
    return true;
  }

  if (key < this.key) {
    if (this.left !== null) {
      return this.left.isPresent(key);
    }
  } else {
    if (this.right !== null) {
      return this.right.isPresent(key);
    }
  }
  return false;
};

/* TODO: define an in-order traversal function which
 * takes a closure.
 */
Node.prototype.collect = function (collector) {
  if (this.left !== null) {
    this.left.collect(collector);
  }
  collector.push(this.key);
  if (this.right !== null) {
    this.right.collect(collector);
  }
};

Node.prototype.list_keys = function () {
  collector = [];
  this.collect(collector);
  return collector;
};

Node.prototype.postOrderTraverse = function (callback) {
  if (this.left !== null) {
    this.left.postOrderTraverse(callback);
  }
  if (this.right !== null) {
    this.right.postOrderTraverse(callback);
  }
  callback(this);
};

Node.prototype.postOrderKeys = function () {
  const collector = [];

  this.postOrderTraverse(function (node) {
    collector.push(node.key);
  });

  return collector;
};

Node.prototype.size = function () {
  let size = 0;
  this.postOrderTraverse(function () {
    size++;
  });
  return size;
};

Node.prototype.invert = function () {
  // console.log(`this.left: ${this.left}, this.right: ${this.right}`);

  this.postOrderTraverse(function (node) {
    // console.log(`before swap node.key: ${node.key}`);
    // console.log(`before swap node.left: ${node.left}`);
    // console.log(`before swap node.right: ${node.right}`);

    const swap = node.left;
    node.left = node.right;
    // console.log(`node.left after swap: ${node.left}`);
    node.right = swap;
    // console.log(`node.right after swap: ${node.right}`);
  });
};

Node.prototype.successor = function (node) {
  const getSuccessor = function (self, node, parent, successor) {
    if (parent.left !== null && parent.left === self) successor = parent;

    if (node === self) {
      if (self.right !== null) {
        return self.right.minimum();
      } else {
        return successor;
      }
    }

    if (node.key < self.key) {
      if (self.left !== null) {
        return getSuccessor(self.left, node, self, successor);
      }
    } else {
      if (self.right !== null) {
        return getSuccessor(self.right, node, self, successor);
      }
    }
  };

  return getSuccessor(this, node, this, node);
};

Node.prototype.predecessor = function (node) {
  const getPredecessor = function (self, node, parent, predecessor) {
    if (parent.right !== null && parent.right === self) {
      predecessor = parent;
    }

    if (node === self) {
      if (self.left !== null) {
        return self.left.maximum();
      } else {
        return predecessor;
      }
    }

    if (node.key < self.key) {
      if (self.left !== null) {
        return getPredecessor(self.left, node, self, predecessor);
      }
    } else {
      if (self.right !== null) {
        return getPredecessor(self.right, node, self, predecessor);
      }
    }
  };

  return getPredecessor(this, node, this, node);
};

Node.prototype.height = function () {
  const height = 0;

  const getHeight = function (n, height) {
    current = height;
    current++;
    // console.log(current)
    let max = 0;
    // if (n.left !== null) { max = n.left.getHeight(current); }
    // if (n.right !== null) { max = n.right.getHeight(current); }

    if (n.left !== null) {
      max = getHeight(n.left, current);
    }
    if (n.right !== null) {
      max = getHeight(n.right, current);
    }

    current--;
    // console.log(current)
    max = current > max ? current : max;
    return max;
  };

  return getHeight(this, height);
};

Node.prototype.isBst = function () {
  // TODO extract this into its own method BST-193
  const inOrderTraverse = function (n, callback) {
    if (n.left !== null) {
      inOrderTraverse(n.left, callback);
    }
    callback(n);
    if (n.right !== null) {
      inOrderTraverse(n.right, callback);
    }
  };

  let result = true;
  let minimum = -10000;
  inOrderTraverse(this, function (node) {
    if (minimum >= node.key) {
      result = false;
    }
    minimum = node.key;
  });
  return result;
};

Node.prototype.isBalanced = function () {
  const checkHeight = function (node) {
    if (node === null) {
      return 0;
    }

    const leftHeight = checkHeight(node.left);
    if (leftHeight === -1) {
      return -1;
    }

    const rightHeight = checkHeight(node.right);
    if (rightHeight === -1) {
      return -1;
    }

    if (Math.abs(leftHeight - rightHeight) > 1) {
      return -1;
    }

    return 1 + Math.max(leftHeight, rightHeight);
  };

  return checkHeight(this);
};

Node.prototype.unlink = function () {
  this.left = this.right = this.parent = null;
};

Node.prototype.isUnlinked = function () {
  return this.left === null && this.right === null && this.parent === null;
};

// I am not sold on this, it requires instantiating a node
// before loading the yaml file. That initial node is otherwise
// useless. Leaving it in for now until I better understand
// prototype behavior.
Node.prototype.fromYaml = function (filename) {
  const fromYaml = require("../lib/from_yaml");

  return fromYaml(filename);
};

exports.Node = Node;
