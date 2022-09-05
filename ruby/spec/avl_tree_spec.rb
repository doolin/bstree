# frozen_string_literal: true

RSpec.describe AvlTree do
  def build_tree(size)
    tree = AvlTree.new(AvlNode.new(1))
    (2..size).to_a.each { |n| tree.insert(AvlNode.new(n)) }
    tree
  end

  # This whole section of specs needs to be reworded.
  # There should be a `describe` here somewhere.
  context 'for building trees of size' do
    example '1' do
      tree = build_tree(1)
      expect(tree.preorder_keys).to eq [1]
      expect(tree.preorder_balance_factors).to eq [0]
      expect(tree.bst?).to be true
      expect(tree.balanced?).to be true
    end

    example '2' do
      tree = build_tree(2)
      expect(tree.preorder_balance_factors).to eq [1, 0]
      expect(tree.root.balance_factor).to eq 1
      expect(tree.root.right.balance_factor).to eq 0
      expect(tree.preorder_keys).to eq [1, 2]
      expect(tree.bst?).to be true
      expect(tree.balanced?).to be true
    end

    example '3' do
      tree = build_tree(3)

      expect(tree.preorder_balance_factors).to eq [0, 0, 0]
      expect(tree.root.balance_factor).to eq 0
      expect(tree.root.left.balance_factor).to eq 0
      expect(tree.root.right.balance_factor).to eq 0

      expect(tree.root.key).to eq 2
      expect(tree.root.left.key).to eq 1
      expect(tree.root.right.key).to eq 3

      expect(tree.preorder_keys).to eq [2, 1, 3]

      expect(tree.bst?).to be true
      expect(tree.balanced?).to be true
    end

    example '4' do
      tree = build_tree(4)
      expect(tree.preorder_keys).to eq [2, 1, 3, 4]

      expect(tree.preorder_balance_factors).to eq [1, 0, 1, 0]
      expect(tree.root.balance_factor).to eq 1
      expect(tree.root.left.balance_factor).to eq 0
      expect(tree.root.right.balance_factor).to eq 1
      expect(tree.root.right.right.balance_factor).to eq 0

      expect(tree.root.key).to be 2
      expect(tree.root.left.key).to be 1
      expect(tree.root.right.key).to be 3
      expect(tree.root.right.right.key).to be 4

      expect(tree.bst?).to be true
      expect(tree.balanced?).to be true
    end

    example '5' do
      tree = build_tree(5)
      expect(tree.root.key).to eq 2

      #          2
      #       1     4
      #           3   5
      expect(tree.preorder_keys).to eq [2, 1, 4, 3, 5]
      expect(tree.bfsearch).to eq [2, 1, 4, 3, 5]
      expect(tree.bst?).to be true
      expect(tree.balanced?).to be true
      expect(tree.root.balance_factor).to eq 1
      expect(tree.root.left.key).to eq 1
      expect(tree.root.right.key).to eq 4
    end
  end

  context 'for counting up' do
    example '6' do
      tree = build_tree(6)
      expected = [4, 2, 1, 3, 5, 6]
      expect(tree.preorder_keys).to eq expected
      expect(tree.root.key).to eq 4
      expect(tree.root.balance_factor).to eq 0
    end

    it 'creates perfect tree of 7 elements' do
      tree = build_tree(7)
      expect(tree.height).to eq 2
      expect(tree.size).to eq 7
      expect(tree.root.key).to be 4
      expected = [4, 2, 1, 3, 6, 5, 7]
      actual = tree.preorder_keys
      expect(actual).to eq expected

      expected = [4, 2, 6, 1, 3, 5, 7]
      expect(tree.bfsearch).to eq expected
    end

    it 'creates perfect tree of 15 elements' do
      tree = build_tree(15)
      expect(tree.height).to be 3
      expect(tree.size).to eq 15
      expect(tree.root.key).to be 8

      expected = [8, 4, 12, 2, 6, 10, 14, 1, 3, 5, 7, 9, 11, 13, 15]
      expect(tree.bfsearch).to eq expected
    end
  end
end
