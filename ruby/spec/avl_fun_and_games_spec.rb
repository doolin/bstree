# frozen_string_literal: true

require_relative '../lib/avl_tree'

RSpec.describe AvlTree do
  let(:n1) { AvlNode.new 1 }
  let(:n2) { AvlNode.new 2 }
  let(:n3) { AvlNode.new 3 }
  let(:n4) { AvlNode.new 4 }
  let(:n5) { AvlNode.new 5 }
  let(:n6) { AvlNode.new 6 }
  let(:n7) { AvlNode.new 7 }
  let(:n8) { AvlNode.new 8 }
  let(:n9) { AvlNode.new 9 }
  let(:n10) { AvlNode.new 10 }
  let(:n11) { AvlNode.new 11 }
  let(:n12) { AvlNode.new 12 }
  let(:n13) { AvlNode.new 13 }
  let(:n14) { AvlNode.new 14 }
  let(:n15) { AvlNode.new 15 }

  def build_tree(size)
    tree = AvlTree.new(AvlNode.new(1))
    (2..size).to_a.each { |n| tree.insert(AvlNode.new(n)) }
    tree
  end

  context 'builds trees of size' do
    example '1' do
      tree = build_tree(1)
      expect(tree.preorder_keys).to eq [1]
    end

    example '2' do
      tree = build_tree(2)
      expect(tree.root.balance_factor).to eq 1
      expect(tree.root.right.balance_factor).to eq 0
      expect(tree.preorder_keys).to eq [1, 2]
    end

    example '3' do
      tree = build_tree(3)

      expect(tree.root.balance_factor).to eq 0
      expect(tree.root.left.balance_factor).to eq 0
      expect(tree.root.right.balance_factor).to eq 0

      expect(tree.root.key).to eq 2
      expect(tree.root.left.key).to eq 1
      expect(tree.root.right.key).to eq 3

      expect(tree.preorder_keys).to eq [2, 1, 3]
    end
  end

  context 'counting up' do
    it 'keys 1-4 are balanced correctly' do
      tree = AvlTree.new n1
      tree.insert n2
      tree.insert n3
      tree.insert n4
      # TODO: write a preorder traverse which collects balance_factor from each node.
      expect(tree.root.balance_factor).to eq 1
      expect(tree.root.right.balance_factor).to eq 1
      expect(tree.root.right.right.balance_factor).to eq 0
      expect(n3.balance_factor).to eq 1

      expect(tree.root.left.balance_factor).to eq 0

      expect(tree.root.left).to eq n1
      expect(tree.root.right).to eq n3
      expect(n3.right).to eq n4
      expect(tree.preorder_keys).to eq [2, 1, 3, 4]
    end

    xit 'inserting key 5' do
      tree = AvlTree.new n1
      tree.insert n2
      tree.insert n3
      tree.insert n4
      expect(tree.preorder_keys).to eq [2, 1, 3, 4]

      tree.insert n5
      expect(tree.root).to eq n2

      # TODO: this is where I go next, from a balanced 2, 1, 3, 4 tree
      # to the following. The way to do this is walk through the various
      # rotations manually, keeping track of state at every step of the
      # way. At some point, I will find the place where the actual state
      # is not what I'm expecting, and that's where I'll start modifying.
      # I expect getting this working is going to require a pretty good
      # overhaul of the current implementation.
      #
      # Also, I should manually write out the the current result before
      # attempting to fix it.
      expect(tree.preorder_keys).to eq [2, 1, 4, 3, 5]
      # expect(tree.root.balance_factor).to eq 1
      # expect(tree.root.left).to eq n1
      # expect(tree.root.right).to eq n4
      # expect(n4.balance_factor).to eq 0
      # expect(n3.balance_factor).to eq 0
      # expect(n4.right).to eq n5
      # expect(n4.left).to eq n3
    end

    xit 'counting past 5' do
      # tree.insert n6
      # expected = [4, 2, 1, 3, 5, 6]
      # expect(tree.preorder_keys).to eq expected
      # expect(tree.root).to eq n4
      # expect(tree.root.balance_factor).to eq 0
      # expect(n1.balance_factor).to eq 0
      # expect(n2.balance_factor).to eq 0
      # expect(n3.balance_factor).to eq 0
      # expect(n4.balance_factor).to eq 0 # root!
      # expect(n5.balance_factor).to eq 1
      # expect(n6.balance_factor).to eq 0

      # "perfect" tree
      # tree.insert n7
      # expect(tree.height).to eq 2
      # expect(tree.size).to eq 7
      # expected = [4, 2, 1, 3, 6, 5, 7]
      # actual = tree.preorder_keys
      # expect(actual).to eq expected

      # tree.insert n8
      # expect(tree.height).to eq 3
      # expect(n7.right).to eq n8

      # tree.insert n9
      # expect(tree.height).to eq 3
      # actual = tree.preorder_keys
      # expected = [6, 4, 2, 1, 3, 5, 8, 7, 9]
      # expect(actual).to eq expected

      # tree.insert n10
      # expect(tree.height).to eq 3
      # actual = tree.preorder_keys
      # expected = [6, 4, 2, 1, 3, 5, 8, 7, 9, 10]
      # expect(actual).to eq expected

      # tree.insert n11
      # Failing here, the tree rotates too far to the left
      # making the left side out of balance. This is going to
      # require working through both the examples on the web
      # and building examples by hand to figure it out. The
      # end goal is a perfect tree with 15 nodes, height 3.
      # I'm pretty sure this is a bookkeeping issue with the
      # rotations, at least, I'm sure hoping so.
      #
      # expect(tree.height).to eq 3
      # actual = tree.preorder_keys
      # puts "actual: #{actual}"

      # This is almost surely not working correctly.
      # I have a hunch that the other rotation needs to
      # be fixed so that it will balance properly. Then
      # again, all the nodes are going in on the far right
      # so it might correct.
      # tree.insert n12
      # # expect(tree.height).to eq 3
      # tree.insert n13
      # # expect(tree.height).to eq 3
      # tree.insert n14
      # # expect(tree.height).to eq 3
      # tree.insert n15
      # # expect(tree.height).to eq 3
      # actual = tree.preorder_keys
      # puts "actual: #{actual}"
    end
  end
end
