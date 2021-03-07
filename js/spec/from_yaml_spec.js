const assert = require('assert');

const from_yaml = require('../lib/from_yaml');

describe('load tree from yaml fixture', () => {
  it('reads tree1 fixture and writes to console', () => {
    let filenode = from_yaml('tree1.yml');

    assert.strictEqual(filenode.size(), 1);
  });

  it('reads tree2 fixture and writes to console', () => {
    let filenode = from_yaml('tree2.yml');

    assert.strictEqual(filenode.size(), 2);
  });

  it('reads tree3 fixture and writes to console', () => {
    let filenode = from_yaml('tree3.yml');

    assert.strictEqual(filenode.size(), 3);
  });

  it('reads tree4 fixture and writes to console', () => {
    let filenode = from_yaml('tree4.yml');

    assert.strictEqual(filenode.size(), 4);
  });

  it('reads tree5 fixture and writes to console', () => {
    let filenode = from_yaml('tree5.yml');

    assert.strictEqual(filenode.size(), 5);
  });

  it('reads tree6 fixture and writes to console', () => {
    let filenode = from_yaml('tree6.yml');

    assert.strictEqual(filenode.size(), 6);
  });

  it('reads tree7 fixture and writes to console', () => {
    let filenode = from_yaml('tree7.yml');

    assert.strictEqual(filenode.size(), 7);
  });

  it('reads tree8 fixture and writes to console', () => {
    let filenode = from_yaml('tree8.yml');

    assert.strictEqual(filenode.size(), 8);
  });

  it('reads tree9 fixture and writes to console', () => {
    let filenode = from_yaml('tree9.yml');

    assert.strictEqual(filenode.size(), 9);
  });

  it('reads tree10 fixture and writes to console', () => {
    let filenode = from_yaml('tree10.yml');

    assert.strictEqual(filenode.size(), 10);
  });
});
