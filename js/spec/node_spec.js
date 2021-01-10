const node = require('../lib/node.js').Node;
const assert = require('assert');

describe('Node', function() {
  describe('instantiation', function() {

    it('creates a Node', function() {
      const root = new node(13);
      assert.equal(13, root.key);
    });
  });

  describe('insertion', function() {
    it('inserts a left node', function() {
      const root = new node(13);
      const n5 = new node(6);
      root.insert(n5);
      assert.equal(root.left, n5);
    });

    it('inserts a right node', function() {
      const root = new node(13);
      const n19 = new node(19);
      root.insert(n19);
      assert.equal(root.right, n19);
    });

    it('insert first 10 primes', function() {
      const root = new node(13);
      const n7 = new node(7);
      const n5 = new node(5);
      const n3 = new node(3);
      const n2 = new node(2);
      const n11 = new node(11);
      const n17 = new node(17);
      const n19 = new node(19);
      const n23 = new node(23);
      const n29 = new node(29);
      root.insert(n5);
      root.insert(n19);
      root.insert(n17);
      root.insert(n23);
      root.insert(n11);
      root.insert(n7);
      root.insert(n3);
      root.insert(n2);
      root.insert(n29);
      assert.equal(root.left.left, n3);
      assert.equal(root.left.left.left, n2);
      assert.equal(root.left.right, n11);
      assert.equal(root.left.right.left, n7);
      assert.equal(root.right, n19);
      assert.equal(root.right.left, n17);
    });
  });

  describe('search and is_present', function() {
    const root = new node(13);
    it('finds a single node', function() {
      assert.equal(root, root.search(13));
      assert.equal(true, root.is_present(13));
      assert.equal(false, root.is_present(-500.55));
    });

    const n5 = new node(5);
    root.insert(n5);
    it('finds node to the left', function() {
      assert.equal(n5, root.search(5));
      assert.equal(true, root.is_present(5));
    });

    const n19 = new node(19);
    root.insert(n19);
    it('finds node to the right', function() {
      assert.equal(n19, root.search(19));
      assert.equal(true, root.is_present(19));
    });

    it('finds nodes in the tree', function() {
      const n7 = new node(7);
      const n3 = new node(3);
      const n2 = new node(2);
      const n11 = new node(11);
      const n17 = new node(17);
      const n23 = new node(23);
      const n29 = new node(29);
      root.insert(n17);
      root.insert(n23);
      root.insert(n11);
      root.insert(n7);
      root.insert(n3);
      root.insert(n2);
      root.insert(n29);
      assert.equal(n17, root.search(17));
      assert.equal(true, root.is_present(17));
      assert.equal(n2, root.search(2));
      assert.equal(true, root.is_present(2));
      assert.equal(false, root.is_present(0.000002));
    });
  });

  describe('collect', function() {
    it('collects a single node', function() {
      const root = new node(13);
      const actual = [];
      const expected = [13];
      root.collect(actual);
      assert.deepEqual(expected, actual);
    });

    it('collects a left node', function() {
      const root = new node(13);
      const n5 = new node(6);
      root.insert(n5);
      const actual = [];
      const expected = [6, 13];
      root.collect(actual);
      assert.deepEqual(expected, actual);
    });

    it('collects a right node', function() {
      const root = new node(13);
      const n19 = new node(19);
      root.insert(n19);
      const expected = [13, 19];
      const actual = [];
      root.collect(actual);
      assert.deepEqual(expected, actual);
    });

    it('collects first 10 primes', function() {
      const root = new node(13);
      const n7 = new node(7);
      const n5 = new node(5);
      const n3 = new node(3);
      const n2 = new node(2);
      const n11 = new node(11);
      const n17 = new node(17);
      const n19 = new node(19);
      const n23 = new node(23);
      const n29 = new node(29);
      root.insert(n5);
      root.insert(n19);
      root.insert(n17);
      root.insert(n23);
      root.insert(n11);
      root.insert(n7);
      root.insert(n3);
      root.insert(n2);
      root.insert(n29);
      const expected = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29];
      const actual = [];
      root.collect(actual);
      assert.deepEqual(expected, actual);
    });
  });

  describe('list_keys', function() {
    it('wraps the collect function for convenience', function() {
      const root = new node(17);
      const expected = [17];
      assert.deepEqual(expected, root.list_keys());
    });
  });


  describe('maximum and minimum', function() {
    it('root node is both maximum and minimum', function() {
      const root = new node(13);
      assert.equal(root.maximum(), root);
      assert.equal(root.minimum(), root);
    });

    it('root maximum with left child minimum', function() {
      const root = new node(13);
      const n5 = new node(5);
      root.insert(n5);
      assert.equal(root.maximum(), root);
      assert.equal(root.minimum(), n5);
    });

    it('root node minimum with right child maximum', function() {
      const root = new node(13);
      const n19 = new node(19);
      root.insert(n19);
      assert.equal(root.maximum(), n19);
      assert.equal(root.minimum(), root);
    });

    it('maximum and minimum for first 10 primes', function() {
      const root = new node(13);
      const n7 = new node(7);
      const n5 = new node(5);
      const n3 = new node(3);
      const n2 = new node(2);
      const n11 = new node(11);
      const n17 = new node(17);
      const n19 = new node(19);
      const n23 = new node(23);
      const n29 = new node(29);
      root.insert(n5);
      root.insert(n19);
      root.insert(n17);
      root.insert(n23);
      root.insert(n11);
      root.insert(n7);
      root.insert(n3);
      root.insert(n2);
      root.insert(n29);
      assert.equal(root.maximum(), n29);
      assert.equal(root.minimum(), n2);
    });
  });

  describe('is_leaf', function() {
    xit('leaf node has no children', function() {
      const root = new node(13);
      assert.equal(root.is_leaf, true);
    });

    xit('insert child node onto leaf', function() {
      const root = new node(13);
      const n11 = new node(11);
      root.insert(n11);
      assert.equal(root.is_leaf, false);
    });
  });

  describe('is_bst', function() {
    it('determines single node is BST', function() {
      const root = new node(17);
      assert.equal(root.is_bst(), true);
    });

    it('BST subtree does not imply whole tree is BST', function() {
      const root = new node(17);
      const n5 = new node(5);
      const n23 = new node(23);
      root.insert(n5);
      root.insert(n23);
      assert.equal(root.is_bst(), true);
      const n14 = new node(14);
      n23.insert(n14);
      assert.equal(n23.is_bst(), true);
      assert.equal(root.is_bst(), false);
    });
  });

  describe('successor and predecessor', function() {
    it('finds successors to nodes in a tree', function() {
      const root = new node(17);
      assert.equal(root.successor(root), root);
      assert.equal(root.predecessor(root), root);

      const n23 = new node(23);
      root.insert(n23);
      assert.equal(root.successor(root), n23);
      assert.equal(root.predecessor(n23), root);

      const n19 = new node(19);
      const n29 = new node(29);
      root.insert(n19);
      root.insert(n29);
      assert.equal(root.successor(root), n19);
      assert.equal(root.predecessor(n19), root);

      assert.equal(root.successor(n19), n23);
      assert.equal(root.predecessor(n23), n19);

      assert.equal(root.successor(n23), n29);
      assert.equal(root.predecessor(n29), n23);

      assert.equal(n29.successor(n29), n29);
      assert.equal(n29.predecessor(n29), n29);

      assert.equal(n19.successor(n19), n19);

      const n2 = new node(2);
      const n3 = new node(3);
      const n5 = new node(5);
      root.insert(n5);
      root.insert(n3);
      root.insert(n2);
      assert.equal(root.successor(n2), n3);
      assert.equal(root.predecessor(n3), n2);

      assert.equal(root.successor(n3), n5);
      assert.equal(root.predecessor(n5), n3);

      assert.equal(root.successor(n5), root);
      assert.equal(root.predecessor(root), n5);

      const n7 = new node(7);
      const n11 = new node(11);
      const n13 = new node(13);
      root.insert(n7);
      root.insert(n11);
      root.insert(n13);
      assert.equal(root.successor(n5), n7);
      assert.equal(root.predecessor(n7), n5);

      assert.equal(root.successor(n7), n11);
      assert.equal(root.predecessor(n11), n7);

      assert.equal(root.successor(n11), n13);
      assert.equal(root.predecessor(n13), n11);

      assert.equal(root.successor(n13), root);
      assert.equal(root.predecessor(root), n13);

      assert.equal(n13.successor(n13), n13);
      assert.equal(n13.predecessor(n13), n13);
    });
  });

  describe('height', function() {
    it('height of single node tree is 0', function() {
      const root = new node(11);
      assert.equal(root.height(), 0);
    });

    it('height of two node tree is 1', function() {
      const root = new node(11);
      const n17 = new node(17);
      root.insert(n17);
      assert.equal(root.height(), 1);
    });

    it('height of balanced three node tree is 1', function() {
      const root = new node(11);
      const n17 = new node(17);
      const n5 = new node(5);
      root.insert(n17);
      root.insert(n5);
      assert.equal(root.height(), 1);
    });

    it('height of tree with 4 or more nodes is at least 2', function() {
      const root = new node(11);
      const n17 = new node(17);
      const n19 = new node(19);
      const n5 = new node(5);
      root.insert(n17);
      root.insert(n19);
      root.insert(n5);
      assert.equal(root.height(), 2);
    });

    it('constious assertions on heights of tree of first 10 primes', function() {
      const root = new node(13);
      const n7 = new node(7);
      const n5 = new node(5);
      const n3 = new node(3);
      const n2 = new node(2);
      const n11 = new node(11);
      const n17 = new node(17);
      const n19 = new node(19);
      const n23 = new node(23);
      const n29 = new node(29);
      root.insert(n5);
      root.insert(n19);
      root.insert(n17);
      root.insert(n23);
      root.insert(n11);
      root.insert(n7);
      root.insert(n3);
      root.insert(n2);
      root.insert(n29);
      assert.equal(root.height(), 3);
      assert.equal(n2.height(), 0);
      assert.equal(n3.height(), 1);
      assert.equal(n5.height(), 2);
      assert.equal(n7.height(), 0);
      assert.equal(n19.height(), 2);
      assert.equal(n29.height(), 0);
      assert.equal(n11.height(), 1);
      assert.equal(n17.height(), 0);
    });
  });

  describe('size', function() {
    it('size 1 for single node tree', function() {
      const root = new node(13);
      assert.equal(root.size(), 1);
    });

    it('size 2 for node with 1 child', function() {
      const root = new node(13);
      const n5 = new node(5);
      root.insert(n5);
      assert.equal(root.size(), 2);
    });

    it('size 10 for first 10 primes', function() {
      const root = new node(13);
      const n7 = new node(7);
      const n5 = new node(5);
      const n3 = new node(3);
      const n2 = new node(2);
      const n11 = new node(11);
      const n17 = new node(17);
      const n19 = new node(19);
      const n23 = new node(23);
      const n29 = new node(29);
      root.insert(n5);
      root.insert(n19);
      root.insert(n17);
      root.insert(n23);
      root.insert(n11);
      root.insert(n7);
      root.insert(n3);
      root.insert(n2);
      root.insert(n29);
      assert.equal(root.size(), 10);
    });
  });

  describe('unlink and is_unlinked', function() {
    it('new nodes are unlinked', function() {
      const n = new node(17);
      assert.equal(n.is_unlinked(), true);
    });

    it('unlink a small tree', function() {
      const root = new node(17);
      const n5 = new node(5);
      const n23 = new node(23);

      root.insert(n5);
      root.insert(n23);
      assert.equal(root.is_unlinked(), false);
      assert.equal(n5.is_unlinked(), false);
      assert.equal(n23.is_unlinked(), false);

      root.unlink();
      n5.unlink();
      n23.unlink();
      assert.equal(root.is_unlinked(), true);
      assert.equal(n5.is_unlinked(), true);
      assert.equal(n23.is_unlinked(), true);
    });
  });
});
