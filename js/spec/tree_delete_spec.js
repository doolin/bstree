const tree = require('../lib/tree.js').Tree;
const node = require('../lib/node.js').Node;
const assert = require('assert');

describe('Tree', function() {
  describe('delete_node', function() {
    it('replaces root with null', function() {
      const root = new node(17);
      const n2 = new node(2);
      const n3 = new node(3);
      const n5 = new node(5);
      const n7 = new node(7);
      const n11 = new node(11);
      const n13 = new node(13);
      const n19 = new node(19);
      const n23 = new node(23);
      const n29 = new node(29);

      const t = new tree();
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
      assert.equal(deleted, n11);
      assert.equal(t.size(), 9);
      assert.equal(n11.is_unlinked(), true);
      assert.equal(n7.right, n13);
      assert.equal(n13.parent, n7);

      deleted = t.delete_node(3);
      assert.equal(deleted, n3);
      assert.equal(t.size(), 8);
      assert.equal(n5.left, n2);
      assert.equal(n2.parent, n5);

      // two children, right child is successor
      deleted = t.delete_node(5);
      assert.equal(deleted, n5);
      assert.equal(t.size(), 7);
      assert.equal(t.root.left, n7);
      assert.equal(n7.parent, t.root);
      assert.equal(n7.left, n2);
      assert.equal(n2.parent, n7);

      // two children, right child it not successor
      deleted = t.delete_node(17);
      assert.equal(deleted, root);
      assert.equal(t.root, n19);
      assert.equal(t.size(), 6);
      assert.equal(n19.right, n23);
      assert.equal(n23.parent, n19);
      assert.equal(n19.left, n7);
      assert.equal(n7.parent, n19);

      t.delete_node(2);
      t.delete_node(13);
      t.delete_node(7);
      t.delete_node(23);
      t.delete_node(19);
      assert.equal(t.root, n29);
      assert.equal(t.size(), 1);
      assert.equal(n29.is_unlinked(), true);

      t.delete_node(29);
      assert.equal(t.size(), 0);
      assert.equal(t.is_empty(), true);
    });
  });
});
