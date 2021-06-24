const Tree = require("../lib/tree.js").Tree;
const Node = require("../lib/node.js").Node;
const assert = require("assert");

describe("Tree", function () {
  describe("instantiation", function () {
    it("creates a Tree", function () {
      const t = new Tree();
      assert.strictEqual(t.root, null);
    });
  });

  describe("transplant", function () {
    it("replaces root with null", function () {
      const t = new Tree();
      const root = new Node(17);
      t.insert(root);
      t.transplant(root, null);
      assert(t.is_empty());
    });

    it("replaces root with left child", function () {
      const t = new Tree();
      const root = new Node(17);
      const n5 = new Node(5);
      t.insert(root);
      t.insert(n5);

      t.transplant(root, n5);
      assert.strictEqual(t.root, n5);
      assert.strictEqual(n5.parent, null);
    });

    it("replaces left child with grandchild", function () {
      const t = new Tree();
      const root = new Node(17);
      const n5 = new Node(5);
      const n7 = new Node(7);
      t.insert(root);
      t.insert(n5);
      t.insert(n7);

      t.transplant(n5, n7);
      assert.strictEqual(t.root.left, n7);
      assert.strictEqual(n7.parent, t.root);
    });

    it("replaces root with right child", function () {
      const t = new Tree();
      const root = new Node(17);
      const n23 = new Node(23);
      t.insert(root);
      t.insert(n23);

      t.transplant(root, n23);
      assert.strictEqual(t.root, n23);
      assert.strictEqual(n23.parent, null);
    });

    it("replaces right child with grnadchild", function () {
      const t = new Tree();
      const root = new Node(17);
      const n23 = new Node(23);
      const n29 = new Node(29);
      t.insert(root);
      t.insert(n23);
      t.insert(n29);

      t.transplant(n23, n29);
      assert.strictEqual(t.root.right, n29);
      assert.strictEqual(n29.parent, t.root);
    });
  });

  describe("insertion", function () {
    it("insert root Node into empty tree", function () {
      const t = new Tree();
      const root = new Node(13);
      t.insert(root);
      assert.strictEqual(t.root, root);
    });

    it("insert left and right Nodes", function () {
      const t = new Tree();
      const root = new Node(13);
      t.insert(root);
      const n5 = new Node(5);
      const n19 = new Node(19);
      t.insert(n5);
      t.insert(n19);
      assert.strictEqual(t.root.left, n5);
      assert.strictEqual(t.root.right, n19);
    });
  });

  describe("search and is_present", function () {
    it("finds an empty tree with no Nodes", function () {
      const t = new Tree();
      assert.strictEqual(false, t.search(13));
    });

    const t = new Tree();
    const root = new Node(13);
    t.insert(root);
    it("finds a single Node", function () {
      assert.strictEqual(root, t.search(13));
      assert.strictEqual(true, t.is_present(13));
      assert.strictEqual(false, t.is_present(5));
      assert.strictEqual(false, t.is_present(-500.55));
    });

    it("finds Node to the left", function () {
      const n5 = new Node(5);
      t.insert(n5);
      assert.strictEqual(n5, t.search(5));
      assert.strictEqual(true, t.is_present(5));
    });

    it("finds Node to the right", function () {
      const n19 = new Node(19);
      t.insert(n19);
      assert.strictEqual(n19, t.search(19));
      assert.strictEqual(true, t.is_present(19));
    });

    it("finds Nodes in the tree", function () {
      const n7 = new Node(7);
      const n3 = new Node(3);
      const n2 = new Node(2);
      const n11 = new Node(11);
      const n17 = new Node(17);
      const n23 = new Node(23);
      const n29 = new Node(29);
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

  describe("collect", function () {
    it("collect empty array from empty tree", function () {
      const t = new Tree();
      const expected = [];
      const actual = [];
      t.collect(actual);
      assert.deepStrictEqual(expected, actual);
    });

    it("collects key for root Node in single Node tree", function () {
      const t = new Tree();
      const root = new Node(13);
      t.insert(root);
      const expected = [13];
      const actual = [];
      t.collect(actual);
      assert.deepStrictEqual(expected, actual);
    });

    it("collects values from a simple 3 Node tree", function () {
      const t = new Tree();
      const root = new Node(13);
      const n5 = new Node(5);
      const n17 = new Node(17);
      t.insert(root);
      t.insert(n5);
      t.insert(n17);
      const expected = [5, 13, 17];
      const actual = [];
      t.collect(actual);
      assert.deepStrictEqual(expected, actual);
    });
  });

  describe("list_keys", function () {
    it("finds no keys for empty tree", function () {
      const t = new Tree();
      assert.deepStrictEqual([], t.list_keys());
    });
  });

  describe("maximum and minimum", function () {
    it("empty tree has null maximum", function () {
      const t = new Tree();
      assert.strictEqual(t.maximum(), null);
    });

    it("root Node is both maximum and minimum", function () {
      const t = new Tree();
      const root = new Node(13);
      t.insert(root);
      assert.strictEqual(t.maximum(), root);
      assert.strictEqual(t.minimum(), root);
    });

    it("root maximum with left child minimum", function () {
      const t = new Tree();
      const root = new Node(13);
      const n5 = new Node(5);
      t.insert(root);
      t.insert(n5);
      assert.strictEqual(t.maximum(), root);
      assert.strictEqual(t.minimum(), n5);
    });

    it("root Node minimum with right child maximum", function () {
      const t = new Tree();
      const root = new Node(13);
      const n19 = new Node(19);
      t.insert(root);
      t.insert(n19);
      assert.strictEqual(root.maximum(), n19);
      assert.strictEqual(root.minimum(), root);
    });

    it("maximum and minimum for first 10 primes", function () {
      const t = new Tree();
      const root = new Node(13);
      const n7 = new Node(7);
      const n5 = new Node(5);
      const n3 = new Node(3);
      const n2 = new Node(2);
      const n11 = new Node(11);
      const n17 = new Node(17);
      const n19 = new Node(19);
      const n23 = new Node(23);
      const n29 = new Node(29);
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

  describe("is_empty", function () {
    it("insert root Node into empty tree", function () {
      const t = new Tree();
      assert.strictEqual(t.is_empty(), true);
    });

    it("insert root Node into empty tree", function () {
      const t = new Tree();
      const root = new Node(13);
      t.insert(root);
      assert.strictEqual(t.is_empty(), false);
    });
  });

  describe("height", function () {
    it("height 0 for tree with 1 Node", function () {
      const t = new Tree();
      const root = new Node(11);
      t.insert(root);
      assert.strictEqual(t.height(), 0);
    });
  });

  describe("successor", function () {
    it("correctly invokes successor", function () {
      const t = new Tree();
      const root = new Node(17);
      t.insert(root);
      assert.strictEqual(t.successor(root), root);
    });
  });

  describe("predecessor", function () {
    it("correctly invokes predecessor", function () {
      const t = new Tree();
      const root = new Node(17);
      t.insert(root);
      assert.strictEqual(t.predecessor(root), root);
    });
  });

  describe("is_empty", function () {
    it("tree with no root is empty", function () {
      const t = new Tree();
      assert(t.is_empty());
    });
  });

  describe("isBst", function () {
    it("determines a single Node is a BST", function () {
      const t = new Tree();
      const root = new Node(17);
      assert.strictEqual(t.isBst(), true);
      t.insert(root);
      assert.strictEqual(t.isBst(), true);
    });
  });

  describe("isBalanced", function () {
    describe("balanced", () => {
      it("null root is balanced", function () {
        const ttt = new Tree();
        assert.strictEqual(ttt.isBalanced(), true);
      });

      it("single Node tree is balanced", function () {
        const tty = new Tree();
        const foo = new Node(44);
        tty.insert(foo);
        assert.strictEqual(tty.isBalanced(), true);
      });
    });

    describe("ubbalanced", () => {
      it("three Node tree is unbalanced", function () {
        const ttx = new Tree();
        const root = new Node(17);
        const n7 = new Node(7);
        const n5 = new Node(5);
        ttx.insert(root);
        ttx.insert(n7);
        ttx.insert(n5);
        assert.strictEqual(ttx.isBalanced(), false);
      });

      it("left weighted full tree is unbalanced", () => {
        const t = new Tree();
        const r = new Node(17);
        const n19 = new Node(19);
        const n16 = new Node(16);
        const n15 = new Node(15);
        const n14 = new Node(14);
        const n13 = new Node(13);
        const n12 = new Node(12);

        t.insert(r);
        t.insert(n19);
        t.insert(n15);
        t.insert(n13);
        t.insert(n12);
        t.insert(n16);
        t.insert(n14);
        assert.strictEqual(t.isBalanced(), false);
      });
    });
  });

  describe("size", function () {
    it("size 0 for empty tree", function () {
      const t = new Tree();
      assert.strictEqual(t.size(), 0);
    });

    it("size 1 for tree with only root Node", function () {
      const t = new Tree();
      const root = new Node(13);
      t.insert(root);
      assert.strictEqual(t.size(), 1);
    });

    it("size 10 for first 10 primes", function () {
      const t = new Tree();
      const root = new Node(13);
      t.insert(root);
      const n7 = new Node(7);
      const n5 = new Node(5);
      const n3 = new Node(3);
      const n2 = new Node(2);
      const n11 = new Node(11);
      const n17 = new Node(17);
      const n19 = new Node(19);
      const n23 = new Node(23);
      const n29 = new Node(29);
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
