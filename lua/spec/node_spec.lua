require 'busted.runner'()

node = require 'lib/node'

describe("instantiating nodes", function()
  it("instantiates a node", function()
    table = {
      key = 11,
      left = nil,
      right = nil
    }
    assert.are.same(table, node:new(11))
  end)
end)

describe("#build_from_table", function()
  local one = {
    key = 1,
    left = nil,
    right = nil
  }

  it("builds single node from a table", function()
    tree = build_from_table(one)
    assert.are.same(tree, one)
  end)

  it("builds #213 tree from a table", function()
    local three = {
      key = 3,
      left = nil,
      right = nil
    }
    local table = {
      key = 2,
      left = one,
      right = three
    }
    local tree = build_from_table(table)

    assert.are.same(tree.key, 2)
    assert.are.same(tree.left.key, 1)
    assert.are.same(tree.right.key, 3)
  end)

  it("builds 5 node tress", function()
    local table = {
      key = 11,
      left = {
        key = 7,
        left = {
          key = 3,
          left = nil,
          right = nil
        },
        right = nil
      },
      right = {
        key = 13,
        left = nil,
        right = {
          key = 19,
          left = one,
          right = three
        }
      }
    }
    local tree = build_from_table(table)

    assert.are.same(tree.key, 11)
    assert.are.same(tree.left.key, 7)
    assert.are.same(tree.right.key, 13)
    assert.are.same(tree.left.left.key, 3)
    assert.are.same(tree.left.right, nil)
    assert.are.same(tree.right.left, nil)
    assert.are.same(tree.right.right.key, 19)
  end)
end)


describe("insert nodes", function()
  it("inserts a single node", function()
    root = node:new(11)
    right = node:new(13)
    root:insert(right)
    assert.are.same(root.right, right)
  end)

  it("inserts left and right nodes", function()
    root = node:new(11)
    right = node:new(13)
    left = node:new(5)
    root:insert(right)
    root:insert(left)
    assert.are.same(root.right, right)
    assert.are.same(root.left, left)
  end)

  it("inserts left and right nodes recursively", function()
    root = node:new(11)
    n17 = node:new(17)
    n13 = node:new(13)
    n5 = node:new(5)
    n7 = node:new(7)
    root:insert(n17)
    root:insert(n13)
    root:insert(n5)
    root:insert(n7)
    assert.are.same(root.right, n17)
    assert.are.same(root.right.left, n13)
    assert.are.same(root.left, n5)
    assert.are.same(root.left.right, n7)
  end)
end)

describe("searches tree for node with key", function()
  setup(function()
    root = node:new(11)
  end)

  it("finds a single node", function()
    assert.are.same(root, root:search(11))
    assert.are.same(true, root:is_present(11))
    assert.are.same(false, root:is_present(41))
  end)

  it("finds the left child in two node tree", function()
    local n5 = node:new(5)
    root:insert(n5)
    assert.are.same(n5, root:search(5))
    assert.are.same(true, root:is_present(5))
  end)

  it("finds the left child in two node tree", function()
    root = node:new(11)
    local n17 = node:new(17)
    root:insert(n17)
    assert.are.same(n17, root:search(17))
    assert.are.same(true, root:is_present(17))
  end)

  it("finds a node in a tree with height greater than 1", function()
    root = node:new(11)
    n17 = node:new(17)
    n13 = node:new(13)
    n5 = node:new(5)
    n7 = node:new(7)
    root:insert(n17)
    root:insert(n13)
    root:insert(n5)
    root:insert(n7)
    assert.are.same(n7, root:search(7))
    assert.are.same(true, root:is_present(7))
    assert.are.same(n13, root:search(13))
    assert.are.same(true, root:is_present(13))
  end)
end)

describe('find maximum or minimum', function()
  setup(function()
    root = node:new(13)
    n19 = node:new(19)
  end)

  it('finds maximum and minimum same for single node', function()
    assert.are.same(root, root:maximum())
    assert.are.same(root, root:minimum())
  end)

  it('finds minimum left child and maximum right child', function()
    local n7 = node:new(7)
    root:insert(n7)
    root:insert(n19)
    assert.are.same(n7, root:minimum())
    assert.are.same(n19, root:maximum())
  end)

  it("finds the value from root and right child", function()
    local n17 = node:new(17)
    local n3 = node:new(3)
    local n5 = node:new(5)
    root:insert(n17)
    root:insert(n3)
    root:insert(n5)

    assert.are.same(n3, root:minimum())
    assert.are.same(n19, root:maximum())
  end)
end)

describe(":height", function()
  setup(function()
    root = node:new(11)
  end)

  it("tree with 1 node has height 0", function()
    assert.are.same(0, root:height())
  end)

  it("tree with two nodes has height 1", function()
    local n3 = node:new(3)
    root:insert(n3)
    assert.are.same(1, root:height())
  end)

  it("tree with three nodes has height 1", function()
    local n13 = node:new(13)
    root:insert(n13)
    assert.are.same(1, root:height())
  end)

  it("tree with four nodes has height 2", function()
    local n19 = node:new(19)
    root:insert(n19)
    assert.are.same(2, root:height())
  end)

  it("tree with leaf maximum increase height by 1 with new maximum", function()
    local n23 = node:new(23)
    root:insert(n23)
    assert.are.same(3, root:height())
  end)
end)

describe(":successor and :predecessor", function()
  it("finds the successors and predecessors for various subtrees", function()
    local root = node:new(17)
    assert.are.same(root, root:successor(root))
    assert.are.same(root, root:predecessor(root))

    local n23 = node:new(23)
    local n19 = node:new(19)
    local n29 = node:new(29)
    root:insert(n23)
    root:insert(n19)
    root:insert(n29)
    assert.are.same(n19, root:successor(root))
    assert.are.same(root, root:predecessor(n19))

    assert.are.same(n29, root:successor(n29))
    assert.are.same(n23, root:predecessor(n29))

    assert.are.same(n23, root:successor(n19))
    assert.are.same(n19, root:predecessor(n23))

    local n2 = node:new(2)
    local n3 = node:new(3)
    local n5 = node:new(5)
    local n7 = node:new(7)
    local n11 = node:new(11)
    local n13 = node:new(13)

    root:insert(n5)
    root:insert(n3)
    root:insert(n2)
    assert.are.same(n3, root:successor(n2))
    assert.are.same(n2, root:predecessor(n3))

    assert.are.same(n5, root:successor(n3))
    assert.are.same(n3, root:predecessor(n5))

    root:insert(n7)
    root:insert(n11)
    root:insert(n13)
    assert.are.same(n7, root:successor(n5))
    assert.are.same(n5, root:predecessor(n7))

    assert.are.same(n11, root:successor(n7))
    assert.are.same(n7, root:predecessor(n11))

    assert.are.same(n13, root:successor(n11))
    assert.are.same(n11, root:predecessor(n13))

    assert.are.same(root, root:successor(n13))
    assert.are.same(n13, root:predecessor(root))
  end)
end)

describe(":size", function()
  it("determines the number of nodes in the tree", function()
    local root = node:new(11)
    assert.are.same(1, root:size())

    local n17 = node:new(17)
    root:insert(n17)
    assert.are.same(2, root:size())

    local n13 = node:new(13)
    root:insert(n13)
    assert.are.same(3, root:size())

    local n5 = node:new(5)
    root:insert(n5)
    assert.are.same(4, root:size())

    local n7 = node:new(7)
    root:insert(n7)
    assert.are.same(5, root:size())
  end)
end)

describe(":is_bst", function()
  it("determines a single node is a BST", function()
    local root = node:new(17)
    assert.are.same(true, root:is_bst())
  end)

  it("finds a three node BST is correct", function()
    local root = node:new(17)
    local n5 = node:new(5)
    local n23 = node:new(23)
    root:insert(n5)
    root:insert(n23)
    assert.are.same(true, root:is_bst())
  end)

  it("determines a BST subtree may lose BST from root node", function()
    local root = node:new(17)
    local n5 = node:new(5)
    local n23 = node:new(23)
    root:insert(n5)
    root:insert(n23)
    local n14 = node:new(14)
    n23:insert(n14)
    assert.are.same(true, n23:is_bst())
    assert.are.same(false, root:is_bst())
  end)
end)

describe("collecting values or labels from nodes in order", function()
  it("collects the value from a single node", function()
    root = node:new(11)
    actual = {}
    root:collect(actual)
    expected = {11}
    assert.are.same(expected, actual)
  end)

  it("collects the value from root and right child", function()
    root = node:new(11)
    n17 = node:new(17)
    root:insert(n17)

    actual = {}
    root:collect(actual)
    expected = {11, 17}
    assert.are.same(expected, actual)
  end)

  it("collects the value from root and left child", function()
    root = node:new(11)
    n7 = node:new(7)
    root:insert(n7)

    actual = {}
    root:collect(actual)
    expected = {7, 11}
    assert.are.same(expected, actual)
  end)

  it("collects the values from arbitrary tree", function()
    root = node:new(11)
    n17 = node:new(17)
    n13 = node:new(13)
    n5 = node:new(5)
    n7 = node:new(7)
    root:insert(n17)
    root:insert(n13)
    root:insert(n5)
    root:insert(n7)

    actual = {}
    root:collect(actual)
    expected = {5, 7, 11, 13, 17}
    assert.are.same(expected, actual)
  end)
end)

describe("unlinked and is_unlinked", function()
  it("unlinks nodes", function()
    root = node:new(17);
    n5 = node:new(5);
    n23 = node:new(23);
    root:insert(n5)
    root:insert(n23)

    assert.are.same(false, root:is_unlinked())
    assert.are.same(false, n5:is_unlinked())
    assert.are.same(false, n23:is_unlinked())

    root:unlink()
    n5:unlink()
    n23:unlink()
    assert.are.same(true, root:is_unlinked())
    assert.are.same(true, n5:is_unlinked())
    assert.are.same(true, n23:is_unlinked())
  end)
end)

describe(":list_keys", function()
  it("lists the keys linked nodes", function()
    root = node:new(17)
    expected = {17}
    assert.are.same(expected, root:list_keys())
  end)
end)
