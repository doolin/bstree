const Tree = require('../lib/tree.js').Tree;
const Node = require('../lib/node.js').Node;
const assert = require('assert');

describe('Tree', function() {
  describe('delete_node', function() {
    it('replaces root with null', function() {
      const root = new Node(17);
      const n2 = new Node(2);
      const n3 = new Node(3);
      const n5 = new Node(5);
      const n7 = new Node(7);
      const n11 = new Node(11);
      const n13 = new Node(13);
      const n19 = new Node(19);
      const n23 = new Node(23);
      const n29 = new Node(29);

      const t = new Tree();
      t.insert(root);
      t.insert(n5);
      t.insert(n3);
      t.insert(n2);
      t.insert(n7);
      t.insert(n11);
      t.insert(n13);
      t.insert(n23);
      t.insert(n19);
      t.insert(n29);

      deleted = t.delete_node(11);
      assert.strictEqual(deleted, n11);
      assert.strictEqual(t.size(), 9);
      assert.strictEqual(n11.is_unlinked(), true);
      assert.strictEqual(n7.right, n13);
      assert.strictEqual(n13.parent, n7);

      deleted = t.delete_node(3);
      assert.strictEqual(deleted, n3);
      assert.strictEqual(t.size(), 8);
      assert.strictEqual(n5.left, n2);
      assert.strictEqual(n2.parent, n5);

      // two children, right child is successor
      deleted = t.delete_node(5);
      assert.strictEqual(deleted, n5);
      assert.strictEqual(t.size(), 7);
      assert.strictEqual(t.root.left, n7);
      assert.strictEqual(n7.parent, t.root);
      assert.strictEqual(n7.left, n2);
      assert.strictEqual(n2.parent, n7);

      // two children, right child it not successor
      deleted = t.delete_node(17);
      assert.strictEqual(deleted, root);
      assert.strictEqual(t.root, n19);
      assert.strictEqual(t.size(), 6);
      assert.strictEqual(n19.right, n23);
      assert.strictEqual(n23.parent, n19);
      assert.strictEqual(n19.left, n7);
      assert.strictEqual(n7.parent, n19);

      t.delete_node(2);
      t.delete_node(13);
      t.delete_node(7);
      t.delete_node(23);
      t.delete_node(19);
      assert.strictEqual(t.root, n29);
      assert.strictEqual(t.size(), 1);
      assert.strictEqual(n29.is_unlinked(), true);

      t.delete_node(29);
      assert.strictEqual(t.size(), 0);
      assert.strictEqual(t.is_empty(), true);
    });
  });
});
