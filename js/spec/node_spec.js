var node = require('../lib/node.js').Node;
var assert = require('assert');

describe('Node', function() {
  describe('instantiation', function() {

    it('creates a Node', function() {
      var root = new node(13);
      assert.equal(13, root.key);
    });
  });

  describe('insertion', function() {
    it('inserts a left node', function() {
      var root = new node(13);
      var n5 = new node(6);
      root.insert(n5);
      assert.equal(root.left, n5);
    });

    it('inserts a right node', function() {
      var root = new node(13);
      var n19 = new node(19);
      root.insert(n19);
      assert.equal(root.right, n19);
    });

    it('insert first 10 primes', function() {
      var root = new node(13);
      var n7 = new node(7);
      var n5 = new node(5);
      var n3 = new node(3);
      var n2 = new node(2);
      var n11 = new node(11);
      var n17 = new node(17);
      var n19 = new node(19);
      var n23 = new node(23);
      var n29 = new node(29);
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
    var root = new node(13);
    it('finds a single node', function() {
      assert.equal(root, root.search(13));
      assert.equal(true, root.is_present(13));
      assert.equal(false, root.is_present(-500.55));
    });

    var n5 = new node(5);
    root.insert(n5);
    it('finds node to the left', function() {
      assert.equal(n5, root.search(5));
      assert.equal(true, root.is_present(5));
    });

    var n19 = new node(19);
    root.insert(n19);
    it('finds node to the right', function() {
      assert.equal(n19, root.search(19));
      assert.equal(true, root.is_present(19));
    });

    it('finds nodes in the tree', function() {
      var n7 = new node(7);
      var n3 = new node(3);
      var n2 = new node(2);
      var n11 = new node(11);
      var n17 = new node(17);
      var n23 = new node(23);
      var n29 = new node(29);
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
      var root = new node(13);
      var actual = [];
      var expected = [13];
      root.collect(actual);
      assert.deepEqual(expected, actual);
    });

    it('collects a left node', function() {
      var root = new node(13);
      var n5 = new node(6);
      root.insert(n5);
      var actual = [];
      var expected = [6, 13];
      root.collect(actual);
      assert.deepEqual(expected, actual);
    });

    it('collects a right node', function() {
      var root = new node(13);
      var n19 = new node(19);
      root.insert(n19);
      var expected = [13, 19];
      var actual = [];
      root.collect(actual);
      assert.deepEqual(expected, actual);
    });

    it('collects first 10 primes', function() {
      var root = new node(13);
      var n7 = new node(7);
      var n5 = new node(5);
      var n3 = new node(3);
      var n2 = new node(2);
      var n11 = new node(11);
      var n17 = new node(17);
      var n19 = new node(19);
      var n23 = new node(23);
      var n29 = new node(29);
      root.insert(n5);
      root.insert(n19);
      root.insert(n17);
      root.insert(n23);
      root.insert(n11);
      root.insert(n7);
      root.insert(n3);
      root.insert(n2);
      root.insert(n29);
      var expected = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29];
      var actual = [];
      root.collect(actual);
      assert.deepEqual(expected, actual);
    });
  });

  describe('maximum and minimum', function() {
    it('root node is both maximum and minimum', function() {
      var root = new node(13);
      assert.equal(root.maximum(), root);
      assert.equal(root.minimum(), root);
    });

    it('root maximum with left child minimum', function() {
      var root = new node(13);
      var n5 = new node(5);
      root.insert(n5);
      assert.equal(root.maximum(), root);
      assert.equal(root.minimum(), n5);
    });

    it('root node minimum with right child maximum', function() {
      var root = new node(13);
      var n19 = new node(19);
      root.insert(n19);
      assert.equal(root.maximum(), n19);
      assert.equal(root.minimum(), root);
    });

    it('maximum and minimum for first 10 primes', function() {
      var root = new node(13);
      var n7 = new node(7);
      var n5 = new node(5);
      var n3 = new node(3);
      var n2 = new node(2);
      var n11 = new node(11);
      var n17 = new node(17);
      var n19 = new node(19);
      var n23 = new node(23);
      var n29 = new node(29);
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
      var root = node.new(13);
      assert.equal(t.is_leaf, true);
    });

    xit('insert child node onto leaf', function() {
      var root = node.new(13);
      var n11 = node.new(11);
      root.insert(n11);
      assert.equal(t.is_leaf, false);
    });
  });

  describe('size', function() {
    xit('size 0 for empty tree', function() {
      var root = node.new(13);
      assert.equal(t.size, 1);
    });

    xit('size 2 for node with 1 child', function() {
      var root = node.new(13);
      var n5 = node.new(n5);
      root.insert(root);
      assert.equal(root.size, 2);
    });

    xit('size 10 for first 10 primes', function() {
      var t = tree.new();
      var root = node.new(13);
      t.insert(root);
      var n7 = node.new(7);
      var n5 = node.new(5);
      var n3 = node.new(3);
      var n2 = node.new(2);
      var n11 = node.new(11);
      var n17 = node.new(17);
      var n19 = node.new(19);
      var n23 = node.new(23);
      var n29 = node.new(29);
      t.insert(n5);
      t.insert(n19);
      //t.insert(n19).insert(17).insert(n23).insert(n11).insert(n7).insert(n3).insert(n2).insert(n29);
      assert.equal(t.size, 10);
    });
  });
});
