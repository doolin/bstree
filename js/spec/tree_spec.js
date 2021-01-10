const tree = require('../lib/tree.js').Tree;
const node = require('../lib/node.js').Node;
const assert = require('assert');

describe('Tree', function() {
  describe('instantiation', function() {
    it('creates a Tree', function() {
      const t = new tree();
      assert.strictEqual(t.root, null);
    });
  });

  describe('transplant', function() {
    it('replaces root with null', function() {
      const t = new tree();
      const root = new node(17);
      t.insert(root);
      t.transplant(root, null);
      assert(t.is_empty());
    });

    it('replaces root with left child', function() {
      const t = new tree();
      const root = new node(17);
      const n5 = new node(5);
      t.insert(root);
      t.insert(n5);

      t.transplant(root, n5);
      assert.strictEqual(t.root, n5);
      assert.strictEqual(n5.parent, null);
    });

    it('replaces left child with grandchild', function() {
      const t = new tree();
      const root = new node(17);
      const n5 = new node(5);
      const n7 = new node(7);
      t.insert(root);
      t.insert(n5);
      t.insert(n7);

      t.transplant(n5, n7);
      assert.strictEqual(t.root.left, n7);
      assert.strictEqual(n7.parent, t.root);
    });

     it('replaces root with right child', function() {
      const t = new tree();
      const root = new node(17);
      const n23 = new node(23);
      t.insert(root);
      t.insert(n23);

      t.transplant(root, n23);
      assert.strictEqual(t.root, n23);
      assert.strictEqual(n23.parent, null);
    });

     it('replaces right child with grnadchild', function() {
      const t = new tree();
      const root = new node(17);
      const n23 = new node(23);
      const n29 = new node(29);
      t.insert(root);
      t.insert(n23);
      t.insert(n29);

      t.transplant(n23, n29);
      assert.strictEqual(t.root.right, n29);
      assert.strictEqual(n29.parent, t.root);
    });
  });

  describe('insertion', function() {
    it('insert root node into empty tree', function() {
      const t = new tree();
      const root = new node(13);
      t.insert(root);
      assert.strictEqual(t.root, root);
    });

    it('insert left and right nodes', function() {
      const t = new tree();
      const root = new node(13);
      t.insert(root);
      const n5 = new node(5);
      const n19 = new node(19);
      t.insert(n5);
      t.insert(n19);
      assert.strictEqual(t.root.left, n5);
      assert.strictEqual(t.root.right, n19);
    });
  });

  describe('search and is_present', function() {
    it('finds an empty tree with no nodes', function() {
      const t = new tree();
      assert.strictEqual(false, t.search(13));
    });

    const t = new tree();
    root = new node(13);
    t.insert(root);
    it('finds a single node', function() {
      assert.strictEqual(root, t.search(13));
      assert.strictEqual(true, t.is_present(13));
      assert.strictEqual(false, t.is_present(5));
      assert.strictEqual(false, t.is_present(-500.55));
    });

    it('finds node to the left', function() {
      const n5 = new node(5);
      t.insert(n5);
      assert.strictEqual(n5, t.search(5));
      assert.strictEqual(true, t.is_present(5));
    });

    it('finds node to the right', function() {
      const n19 = new node(19);
      t.insert(n19);
      assert.strictEqual(n19, t.search(19));
      assert.strictEqual(true, t.is_present(19));
    });

    it('finds nodes in the tree', function() {
      const n7 = new node(7);
      const n3 = new node(3);
      const n2 = new node(2);
      const n11 = new node(11);
      const n17 = new node(17);
      const n23 = new node(23);
      const n29 = new node(29);
      t.insert(n17);
      t.insert(n23);
      t.insert(n11);
      t.insert(n7);
      t.insert(n3);
      t.insert(n2);
      t.insert(n29);
      assert.strictEqual(n17, t.search(17));
      assert.strictEqual(true, t.is_present(17));
      assert.strictEqual(n2, t.search(2));
      assert.strictEqual(true, t.is_present(2));
      assert.strictEqual(false, t.is_present(0.000002));
    });
  });

  describe('collect', function() {
    it('collect empty array from empty tree', function() {
      const t = new tree();
      const expected = [];
      const actual = [];
      t.collect(actual);
      assert.deepStrictEqual(expected, actual);
    });

    it('collects key for root node in single node tree', function() {
      const t = new tree();
      const root = new node(13);
      t.insert(root);
      const expected = [13];
      const actual = [];
      t.collect(actual);
      assert.deepStrictEqual(expected, actual);
    });

    it('collects values from a simple 3 node tree', function() {
      const t = new tree();
      const root = new node(13);
      const n5 = new node(5);
      const n17 = new node(17);
      t.insert(root);
      t.insert(n5);
      t.insert(n17);
      const expected = [5, 13, 17];
      const actual = [];
      t.collect(actual);
      assert.deepStrictEqual(expected, actual);
    });
  });

  describe('list_keys', function() {
    it('finds no keys for empty tree', function() {
      const t = new tree();
      assert.deepStrictEqual([], t.list_keys());
    });
  });

  describe('maximum and minimum', function() {
    it('empty tree has null maximum', function() {
      const t = new tree();
      assert.strictEqual(t.maximum(), null);
    });

    it('root node is both maximum and minimum', function() {
      const t = new tree();
      const root = new node(13);
      t.insert(root);
      assert.strictEqual(t.maximum(), root);
      assert.strictEqual(t.minimum(), root);
    });

    it('root maximum with left child minimum', function() {
      const t = new tree();
      const root = new node(13);
      const n5 = new node(5);
      t.insert(root);
      t.insert(n5);
      assert.strictEqual(t.maximum(), root);
      assert.strictEqual(t.minimum(), n5);
    });

    it('root node minimum with right child maximum', function() {
      const t = new tree();
      const root = new node(13);
      const n19 = new node(19);
      t.insert(root);
      t.insert(n19);
      assert.strictEqual(root.maximum(), n19);
      assert.strictEqual(root.minimum(), root);
    });

    it('maximum and minimum for first 10 primes', function() {
      const t = new tree();
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
      t.insert(root);
      t.insert(n5);
      t.insert(n19);
      t.insert(n17);
      t.insert(n23);
      t.insert(n11);
      t.insert(n7);
      t.insert(n3);
      t.insert(n2);
      t.insert(n29);
      assert.strictEqual(t.maximum(), n29);
      assert.strictEqual(t.minimum(), n2);
    });
  });

  describe('is_empty', function() {
    it('insert root node into empty tree', function() {
      const t = new tree();
      assert.strictEqual(t.is_empty(), true);
    });

    it('insert root node into empty tree', function() {
      const t = new tree();
      const root = new node(13);
      t.insert(root);
      assert.strictEqual(t.is_empty(), false);
    });
  });

  describe('height', function() {
    it('height 0 for tree with 1 node', function() {
      const t = new tree();
      const root = new node(11);
      t.insert(root);
      assert.strictEqual(t.height(), 0);
    });
  });

  describe('successor', function() {
    it('correctly invokes successor', function() {
      const t = new tree();
      const root = new node(17);
      t.insert(root);
      assert.strictEqual(t.successor(root), root);
    });
  });

  describe('predecessor', function() {
    it('correctly invokes predecessor', function() {
      const t = new tree();
      const root = new node(17);
      t.insert(root);
      assert.strictEqual(t.predecessor(root), root);
    });
  });

  describe('is_empty', function() {
    it('tree with no root is empty', function() {
      const t = new tree();
      assert(t.is_empty());
    });
  });

  describe('is_bst', function() {
    it('determines a single node is a BST', function() {
      const t = new tree();
      const root = new node(17);
      assert.strictEqual(t.is_bst(), true);
      t.insert(root);
      assert.strictEqual(t.is_bst(), true);
    });
  });

  describe('size', function() {
    it('size 0 for empty tree', function() {
      const t = new tree();
      assert.strictEqual(t.size(), 0);
    });

    it('size 1 for tree with only root node', function() {
      const t = new tree();
      const root = new node(13);
      t.insert(root);
      assert.strictEqual(t.size(), 1);
    });

    it('size 10 for first 10 primes', function() {
      const t = new tree();
      const root = new node(13);
      t.insert(root);
      const n7 = new node(7);
      const n5 = new node(5);
      const n3 = new node(3);
      const n2 = new node(2);
      const n11 = new node(11);
      const n17 = new node(17);
      const n19 = new node(19);
      const n23 = new node(23);
      const n29 = new node(29);
      t.insert(n5);
      t.insert(n19);
      t.insert(n17);
      t.insert(n23);
      t.insert(n11);
      t.insert(n7);
      t.insert(n3);
      t.insert(n2);
      t.insert(n29);
      assert.strictEqual(t.size(), 10);
    });
  });
});
