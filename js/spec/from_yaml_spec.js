const assert = require("assert");

const fromYaml = require("../lib/from_yaml");

describe("load tree from yaml fixture", () => {
  it("reads tree1 fixture and writes to console", () => {
    const filenode = fromYaml("tree1.yml");

    assert.strictEqual(filenode.size(), 1);
    assert.strictEqual(filenode.height(), 0);
    assert.strictEqual(filenode.isBst(), true);
    // assert.strictEqual(filenode.isFull(), true)
    assert.strictEqual(filenode.isBalanced(), true);
    assert.deepStrictEqual(filenode.postOrderKeys(), [11]);
    assert.deepStrictEqual(filenode.preOrderKeys(), [11]);
    // expect(tree1.isPathogical).to be false
  });

  it("reads tree2 fixture and writes to console", () => {
    const filenode = fromYaml("tree2.yml");

    assert.strictEqual(filenode.size(), 2);
    assert.strictEqual(filenode.height(), 1);
    assert.strictEqual(filenode.isBst(), true);
    // assert.strictEqual(filenode.isFull(), false)
    assert.strictEqual(filenode.isBalanced(), true);
    assert.deepStrictEqual(filenode.postOrderKeys(), [7, 11]);
    assert.deepStrictEqual(filenode.preOrderKeys(), [11, 7]);
    // expect(tree1.isPathogical).to be false
  });

  it("reads tree3 fixture and writes to console", () => {
    const filenode = fromYaml("tree3.yml");

    assert.strictEqual(filenode.size(), 3);
    assert.strictEqual(filenode.height(), 1);
    assert.strictEqual(filenode.isBst(), true);
    // assert.strictEqual(filenode.isFull(), true)
    assert.strictEqual(filenode.isBalanced(), true);
    assert.deepStrictEqual(filenode.postOrderKeys(), [7, 13, 11]);
    assert.deepStrictEqual(filenode.preOrderKeys(), [11, 7, 13]);
    // expect(tree1.isPathogical).to be false
  });

  it("reads tree4 fixture and writes to console", () => {
    const filenode = fromYaml("tree4.yml");

    assert.strictEqual(filenode.size(), 4);
    assert.strictEqual(filenode.height(), 2);
    assert.strictEqual(filenode.isBst(), true);
    // assert.strictEqual(filenode.isFull(), false)
    assert.strictEqual(filenode.isBalanced(), true);
    assert.deepStrictEqual(filenode.postOrderKeys(), [3, 7, 13, 11]);
    assert.deepStrictEqual(filenode.preOrderKeys(), [11, 7, 3, 13]);
    // expect(tree1.isPathogical).to be false
  });

  it("reads tree5 fixture and writes to console", () => {
    const filenode = fromYaml("tree5.yml");

    assert.strictEqual(filenode.size(), 5);
    assert.strictEqual(filenode.height(), 2);
    assert.strictEqual(filenode.isBst(), true);
    // assert.strictEqual(filenode.isFull(), false)
    assert.strictEqual(filenode.isBalanced(), true);
    assert.deepStrictEqual(filenode.postOrderKeys(), [3, 7, 19, 13, 11]);
    assert.deepStrictEqual(filenode.preOrderKeys(), [11, 7, 3, 13, 19]);
    // expect(tree1.isPathogical).to be false
  });

  it("reads tree6 fixture and writes to console", () => {
    const filenode = fromYaml("tree6.yml");

    assert.strictEqual(filenode.size(), 6);
    assert.strictEqual(filenode.height(), 3);
    assert.strictEqual(filenode.isBst(), true);
    // assert.strictEqual(filenode.isFull(), false)
    assert.strictEqual(filenode.isBalanced(), false);
    assert.deepStrictEqual(filenode.postOrderKeys(), [3, 7, 29, 19, 13, 11]);
    assert.deepStrictEqual(filenode.preOrderKeys(), [11, 7, 3, 13, 19, 29]);
    // expect(tree1.isPathogical).to be false
  });

  it("reads tree7 fixture and writes to console", () => {
    const filenode = fromYaml("tree7.yml");

    assert.strictEqual(filenode.size(), 7);
    assert.strictEqual(filenode.height(), 3);
    assert.strictEqual(filenode.isBst(), true);
    // assert.strictEqual(filenode.isFull(), false)
    assert.strictEqual(filenode.isBalanced(), false);
    assert.deepStrictEqual(filenode.postOrderKeys(), [5, 3, 7, 29, 19, 13, 11]);
    assert.deepStrictEqual(filenode.preOrderKeys(), [11, 7, 3, 5, 13, 19, 29]);
    // expect(tree1.isPathogical).to be false
  });

  it("reads tree8 fixture and writes to console", () => {
    const filenode = fromYaml("tree8.yml");

    assert.strictEqual(filenode.size(), 8);
    assert.strictEqual(filenode.height(), 3);
    assert.strictEqual(filenode.isBst(), true);
    // assert.strictEqual(filenode.isFull(), false)
    assert.strictEqual(filenode.isBalanced(), false);
    assert.deepStrictEqual(
      filenode.postOrderKeys(),
      [2, 5, 3, 7, 29, 19, 13, 11],
    );
    assert.deepStrictEqual(
      filenode.preOrderKeys(),
      [11, 7, 3, 2, 5, 13, 19, 29],
    );
    // expect(tree1.isPathogical).to be false
  });

  it("reads tree9 fixture and writes to console", () => {
    const filenode = fromYaml("tree9.yml");

    assert.strictEqual(filenode.size(), 9);
    assert.strictEqual(filenode.height(), 3);
    assert.strictEqual(filenode.isBst(), true);
    // assert.strictEqual(filenode.isFull(), false)
    assert.strictEqual(filenode.isBalanced(), false);
    assert.deepStrictEqual(
      filenode.postOrderKeys(),
      [2, 5, 3, 7, 17, 29, 19, 13, 11],
    );
    assert.deepStrictEqual(
      filenode.preOrderKeys(),
      [11, 7, 3, 2, 5, 13, 19, 17, 29],
    );
    // expect(tree1.isPathogical).to be false
  });

  it("reads tree10 fixture and writes to console", () => {
    const filenode = fromYaml("tree10.yml");

    assert.strictEqual(filenode.size(), 10);
    assert.strictEqual(filenode.height(), 4);
    assert.strictEqual(filenode.isBst(), true);
    // assert.strictEqual(filenode.isFull(), false)
    assert.strictEqual(filenode.isBalanced(), false);
    assert.deepStrictEqual(
      filenode.postOrderKeys(),
      [2, 5, 3, 7, 17, 23, 29, 19, 13, 11],
    );
    assert.deepStrictEqual(
      filenode.preOrderKeys(),
      [11, 7, 3, 2, 5, 13, 19, 17, 29, 23],
    );
    // expect(tree1.isPathogical).to be false
  });
});
