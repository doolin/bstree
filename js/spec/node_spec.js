const Node = require("../lib/node.js").Node;
const assert = require("assert");

describe("load yaml from fixtures", () => {
  it("reads a fixture and writes to console", () => {
    root = new Node(17);
    const filenode = root.fromYaml("tree1.yml");

    assert.strictEqual(filenode.size(), 1);
  });

  it("reads a fixture and writes to console", () => {
    root = new Node(17);
    const filenode = root.fromYaml("tree2.yml");

    assert.strictEqual(filenode.size(), 2);
  });

  it("reads a fixture and writes to console", () => {
    root = new Node(17);
    const filenode = root.fromYaml("tree3.yml");

    assert.strictEqual(filenode.size(), 3);
  });

  it("reads a fixture and writes to console", () => {
    root = new Node(17);
    const filenode = root.fromYaml("tree4.yml");

    assert.strictEqual(filenode.size(), 4);
  });

  it("reads a fixture and writes to console", () => {
    root = new Node(17);
    const filenode = root.fromYaml("tree5.yml");

    assert.strictEqual(filenode.size(), 5);
  });

  it("reads a fixture and writes to console", () => {
    root = new Node(17);
    const filenode = root.fromYaml("tree6.yml");

    assert.strictEqual(filenode.size(), 6);
  });

  it("reads a fixture and writes to console", () => {
    root = new Node(17);
    const filenode = root.fromYaml("tree7.yml");

    assert.strictEqual(filenode.size(), 7);
  });

  it("reads a fixture and writes to console", () => {
    root = new Node(17);
    const filenode = root.fromYaml("tree8.yml");

    assert.strictEqual(filenode.size(), 8);
  });

  it("reads a fixture and writes to console", () => {
    root = new Node(17);
    const filenode = root.fromYaml("tree9.yml");

    assert.strictEqual(filenode.size(), 9);
  });

  it("reads a fixture and writes to console", () => {
    root = new Node(17);
    const filenode = root.fromYaml("tree10.yml");

    assert.strictEqual(filenode.size(), 10);
  });
});

describe("Node", function () {
  describe("instantiation", function () {
    it("creates a Node", function () {
      const root = new Node(13);
      assert.strictEqual(13, root.key);
    });
  });

  describe("insertion", function () {
    it("inserts a left node", function () {
      const root = new Node(13);
      const n5 = new Node(6);
      root.insert(n5);
      assert.strictEqual(root.left, n5);
    });

    it("inserts a right node", function () {
      const root = new Node(13);
      const n19 = new Node(19);
      root.insert(n19);
      assert.strictEqual(root.right, n19);
    });

    it("insert first 10 primes", function () {
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
      root.insert(n5);
      root.insert(n19);
      root.insert(n17);
      root.insert(n23);
      root.insert(n11);
      root.insert(n7);
      root.insert(n3);
      root.insert(n2);
      root.insert(n29);
      assert.strictEqual(root.left.left, n3);
      assert.strictEqual(root.left.left.left, n2);
      assert.strictEqual(root.left.right, n11);
      assert.strictEqual(root.left.right.left, n7);
      assert.strictEqual(root.right, n19);
      assert.strictEqual(root.right.left, n17);
    });
  });

  describe("search and is_present", function () {
    const root = new Node(13);
    it("finds a single node", function () {
      assert.strictEqual(root, root.search(13));
      assert.strictEqual(true, root.is_present(13));
      assert.strictEqual(false, root.is_present(-500.55));
    });

    const n5 = new Node(5);
    root.insert(n5);
    it("finds node to the left", function () {
      assert.strictEqual(n5, root.search(5));
      assert.strictEqual(true, root.is_present(5));
    });

    const n19 = new Node(19);
    root.insert(n19);
    it("finds node to the right", function () {
      assert.strictEqual(n19, root.search(19));
      assert.strictEqual(true, root.is_present(19));
    });

    it("finds nodes in the tree", function () {
      const n7 = new Node(7);
      const n3 = new Node(3);
      const n2 = new Node(2);
      const n11 = new Node(11);
      const n17 = new Node(17);
      const n23 = new Node(23);
      const n29 = new Node(29);
      root.insert(n17);
      root.insert(n23);
      root.insert(n11);
      root.insert(n7);
      root.insert(n3);
      root.insert(n2);
      root.insert(n29);
      assert.strictEqual(n17, root.search(17));
      assert.strictEqual(true, root.is_present(17));
      assert.strictEqual(n2, root.search(2));
      assert.strictEqual(true, root.is_present(2));
      assert.strictEqual(false, root.is_present(0.000002));
    });
  });

  describe("collect", function () {
    it("collects a single node", function () {
      const root = new Node(13);
      const actual = [];
      const expected = [13];
      root.collect(actual);
      assert.deepStrictEqual(expected, actual);
    });

    it("collects a left node", function () {
      const root = new Node(13);
      const n5 = new Node(6);
      root.insert(n5);
      const actual = [];
      const expected = [6, 13];
      root.collect(actual);
      assert.deepStrictEqual(expected, actual);
    });

    it("collects a right node", function () {
      const root = new Node(13);
      const n19 = new Node(19);
      root.insert(n19);
      const expected = [13, 19];
      const actual = [];
      root.collect(actual);
      assert.deepStrictEqual(expected, actual);
    });

    it("collects first 10 primes", function () {
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
      assert.deepStrictEqual(expected, actual);
    });
  });

  describe("list_keys", function () {
    it("wraps the collect function for convenience", function () {
      const root = new Node(17);
      const expected = [17];
      assert.deepStrictEqual(expected, root.list_keys());
    });
  });

  describe("maximum and minimum", function () {
    it("root node is both maximum and minimum", function () {
      const root = new Node(13);
      assert.strictEqual(root.maximum(), root);
      assert.strictEqual(root.minimum(), root);
    });

    it("root maximum with left child minimum", function () {
      const root = new Node(13);
      const n5 = new Node(5);
      root.insert(n5);
      assert.strictEqual(root.maximum(), root);
      assert.strictEqual(root.minimum(), n5);
    });

    it("root node minimum with right child maximum", function () {
      const root = new Node(13);
      const n19 = new Node(19);
      root.insert(n19);
      assert.strictEqual(root.maximum(), n19);
      assert.strictEqual(root.minimum(), root);
    });

    it("maximum and minimum for first 10 primes", function () {
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
      root.insert(n5);
      root.insert(n19);
      root.insert(n17);
      root.insert(n23);
      root.insert(n11);
      root.insert(n7);
      root.insert(n3);
      root.insert(n2);
      root.insert(n29);
      assert.strictEqual(root.maximum(), n29);
      assert.strictEqual(root.minimum(), n2);
    });
  });

  describe("is_leaf", function () {
    xit("leaf node has no children", function () {
      const root = new Node(13);
      assert.strictEqual(root.is_leaf, true);
    });

    xit("insert child node onto leaf", function () {
      const root = new Node(13);
      const n11 = new Node(11);
      root.insert(n11);
      assert.strictEqual(root.is_leaf, false);
    });
  });

  describe("isBst", function () {
    it("determines single node is BST", function () {
      const root = new Node(17);
      assert.strictEqual(root.isBst(), true);
    });

    it("BST subtree does not imply whole tree is BST", function () {
      const root = new Node(17);
      const n5 = new Node(5);
      const n23 = new Node(23);
      root.insert(n5);
      root.insert(n23);
      assert.strictEqual(root.isBst(), true);
      const n14 = new Node(14);
      n23.insert(n14);
      assert.strictEqual(n23.isBst(), true);
      assert.strictEqual(root.isBst(), false);
    });
  });

  describe("successor and predecessor", function () {
    it("finds successors to nodes in a tree", function () {
      const root = new Node(17);
      assert.strictEqual(root.successor(root), root);
      assert.strictEqual(root.predecessor(root), root);

      const n23 = new Node(23);
      root.insert(n23);
      assert.strictEqual(root.successor(root), n23);
      assert.strictEqual(root.predecessor(n23), root);

      const n19 = new Node(19);
      const n29 = new Node(29);
      root.insert(n19);
      root.insert(n29);
      assert.strictEqual(root.successor(root), n19);
      assert.strictEqual(root.predecessor(n19), root);

      assert.strictEqual(root.successor(n19), n23);
      assert.strictEqual(root.predecessor(n23), n19);

      assert.strictEqual(root.successor(n23), n29);
      assert.strictEqual(root.predecessor(n29), n23);

      assert.strictEqual(n29.successor(n29), n29);
      assert.strictEqual(n29.predecessor(n29), n29);

      assert.strictEqual(n19.successor(n19), n19);

      const n2 = new Node(2);
      const n3 = new Node(3);
      const n5 = new Node(5);
      root.insert(n5);
      root.insert(n3);
      root.insert(n2);
      assert.strictEqual(root.successor(n2), n3);
      assert.strictEqual(root.predecessor(n3), n2);

      assert.strictEqual(root.successor(n3), n5);
      assert.strictEqual(root.predecessor(n5), n3);

      assert.strictEqual(root.successor(n5), root);
      assert.strictEqual(root.predecessor(root), n5);

      const n7 = new Node(7);
      const n11 = new Node(11);
      const n13 = new Node(13);
      root.insert(n7);
      root.insert(n11);
      root.insert(n13);
      assert.strictEqual(root.successor(n5), n7);
      assert.strictEqual(root.predecessor(n7), n5);

      assert.strictEqual(root.successor(n7), n11);
      assert.strictEqual(root.predecessor(n11), n7);

      assert.strictEqual(root.successor(n11), n13);
      assert.strictEqual(root.predecessor(n13), n11);

      assert.strictEqual(root.successor(n13), root);
      assert.strictEqual(root.predecessor(root), n13);

      assert.strictEqual(n13.successor(n13), n13);
      assert.strictEqual(n13.predecessor(n13), n13);
    });
  });

  describe("height", function () {
    it("height of single node tree is 0", function () {
      const root = new Node(11);
      assert.strictEqual(root.height(), 0);
    });

    it("height of two node tree is 1", function () {
      const root = new Node(11);
      const n17 = new Node(17);
      root.insert(n17);
      assert.strictEqual(root.height(), 1);
    });

    it("height of balanced three node tree is 1", function () {
      const root = new Node(11);
      const n17 = new Node(17);
      const n5 = new Node(5);
      root.insert(n17);
      root.insert(n5);
      assert.strictEqual(root.height(), 1);
    });

    it("height of tree with 4 or more nodes is at least 2", function () {
      const root = new Node(11);
      const n17 = new Node(17);
      const n19 = new Node(19);
      const n5 = new Node(5);
      root.insert(n17);
      root.insert(n19);
      root.insert(n5);
      assert.strictEqual(root.height(), 2);
    });

    it("heights of tree of first 10 primes", function () {
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
      root.insert(n5);
      root.insert(n19);
      root.insert(n17);
      root.insert(n23);
      root.insert(n11);
      root.insert(n7);
      root.insert(n3);
      root.insert(n2);
      root.insert(n29);
      assert.strictEqual(root.height(), 3);
      assert.strictEqual(n2.height(), 0);
      assert.strictEqual(n3.height(), 1);
      assert.strictEqual(n5.height(), 2);
      assert.strictEqual(n7.height(), 0);
      assert.strictEqual(n19.height(), 2);
      assert.strictEqual(n29.height(), 0);
      assert.strictEqual(n11.height(), 1);
      assert.strictEqual(n17.height(), 0);
    });
  });

  describe("size", function () {
    it("size 1 for single node tree", function () {
      const root = new Node(13);
      assert.strictEqual(root.size(), 1);
    });

    it("size 2 for node with 1 child", function () {
      const root = new Node(13);
      const n5 = new Node(5);
      root.insert(n5);
      assert.strictEqual(root.size(), 2);
    });

    it("size 10 for first 10 primes", function () {
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
      root.insert(n5);
      root.insert(n19);
      root.insert(n17);
      root.insert(n23);
      root.insert(n11);
      root.insert(n7);
      root.insert(n3);
      root.insert(n2);
      root.insert(n29);
      assert.strictEqual(root.size(), 10);
    });
  });

  describe("unlink and is_unlinked", function () {
    it("new nodes are unlinked", function () {
      const n = new Node(17);
      assert.strictEqual(n.is_unlinked(), true);
    });

    it("unlink a small tree", function () {
      const root = new Node(17);
      const n5 = new Node(5);
      const n23 = new Node(23);

      root.insert(n5);
      root.insert(n23);
      assert.strictEqual(root.is_unlinked(), false);
      assert.strictEqual(n5.is_unlinked(), false);
      assert.strictEqual(n23.is_unlinked(), false);

      root.unlink();
      n5.unlink();
      n23.unlink();
      assert.strictEqual(root.is_unlinked(), true);
      assert.strictEqual(n5.is_unlinked(), true);
      assert.strictEqual(n23.is_unlinked(), true);
    });
  });

  describe("invert", () => {
    it("inverts a single node", () => {
      const root = new Node(17);
      root.invert();
      assert.strictEqual(root.left, null);
      assert.strictEqual(root.right, null);
    });

    it("inverts root with left node", () => {
      const root = new Node(17);
      const n5 = new Node(5);
      root.insert(n5);
      root.invert();

      assert.strictEqual(root.left, null);
      assert.strictEqual(root.right, n5);
    });

    it("inverts root with right node", () => {
      const root = new Node(17);
      const n23 = new Node(23);
      root.insert(n23);
      root.invert();

      assert.strictEqual(root.left, n23);
      assert.strictEqual(root.right, null);
    });

    it("inverts root with left and right nodes", () => {
      const root = new Node(17);
      const n5 = new Node(5);
      const n23 = new Node(23);
      root.insert(n5);
      root.insert(n23);
      root.invert();

      assert.strictEqual(root.left, n23);
      assert.strictEqual(root.right, n5);
    });

    it("inverts full tree of depth two", () => {
      const root = new Node(17);
      // left branch
      const n11 = new Node(11);
      const n5 = new Node(5);
      const n13 = new Node(13);
      root.insert(n11);
      root.insert(n13);
      root.insert(n5);

      // right branch
      const n23 = new Node(23);
      const n17 = new Node(17);
      const n29 = new Node(29);
      root.insert(n23);
      root.insert(n29);
      root.insert(n17);

      root.invert();

      assert.strictEqual(root.left, n23);
      assert.strictEqual(root.right, n11);

      assert.strictEqual(n11.left, n13);
      assert.strictEqual(n11.right, n5);

      assert.strictEqual(n23.left, n29);
      assert.strictEqual(n23.right, n17);
    });
  });
});
