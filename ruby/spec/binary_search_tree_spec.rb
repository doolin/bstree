# frozen_string_literal: true

require_relative './spec_helper'

require 'shared_examples/successor'
require 'shared_examples/predecessor'

# Binary search tree module wrapper for testing.
# There may be a better way to do this with anonymous
# classes, but those have state issues in RSpec,
# particularly when instantiated via `let` blocks.
class BstTest
  require 'securerandom'
  include BinarySearchTree
  attr_reader :key, :uuid

  def initialize(key)
    @key = key
    @uuid = SecureRandom.uuid
  end

  def <(other)
    @key < other.key
  end

  def <=(other)
    @key <= other.key
  end
end

RSpec.describe BstTest do # rubocop:disable RSpec/FilePath
  it_finds '#successor'
  it_finds '#predecessor'

  describe 'algorithm methods' do
    let(:expected) { [2, 3, 5, 7, 11, 13, 23, 29] }
    let(:root) { described_class.new(11) }
    let(:foo2) { described_class.new(2) }
    let(:foo5) { described_class.new(5) }
    let(:foo7) { described_class.new(7) }
    let(:foo13) { described_class.new(13) }
    let(:foo29) { described_class.new(29) }

    before do
      foo3 = described_class.new(3)
      foo23 = described_class.new(23)

      root.insert(foo13)
      root.insert(foo5)
      root.insert(foo2)
      root.insert(foo3)
      root.insert(foo7)
      root.insert(foo23)
      root.insert(foo29)
    end

    describe '.bst?' do
      it 'determines whether a tree is a binary search tree' do
        expect(root.bst?).to be true
      end

      it 'identifies single node as binary search tree' do
        node = described_class.new(11)
        expect(node.bst?).to be true
      end

      it 'identifies root and left node as binary search tree' do
        node = described_class.new(11)
        left = described_class.new(5)
        node.insert left
        expect(node.bst?).to be true
      end

      it 'identifies root and right node as binary search tree' do
        node = described_class.new(11)
        right = described_class.new(15)
        node.insert right
        expect(node.bst?).to be true
      end

      it 'identifies three node as binary search tree' do
        node = described_class.new(11)
        left = described_class.new(5)
        right = described_class.new(15)
        node.insert left
        node.insert right
        expect(node.bst?).to be true
      end

      it 'identifies three node as not a binary search tree' do
        node = described_class.new 11
        left = described_class.new 5
        right = described_class.new 15
        node.left = right
        node.right = left
        expect(node.bst?).to be false
      end

      it 'finds bst violation with wrongly inserted nodes' do
        root = described_class.new(17)
        n20 = described_class.new(20)
        root.insert n20
        n20.insert(described_class.new(1))
        n20.insert(described_class.new(100))
        expect(n20.bst?).to be true
        expect(root.bst?).to be false
      end
    end

    describe '.search' do
      it 'finds the root node using the key' do
        expect(root.search(11)).to eq root
      end

      it 'finds the root.left node using the key' do
        expect(root.search(5)).to eq root.left
      end

      it 'finds the root.right node using the key' do
        expect(root.search(13)).to eq root.right
      end

      it 'finds an arbitrary node using the key' do
        expect(root.search(7)).to eq foo7
      end
    end

    describe '.present?' do
      it 'finds the root node using the key' do
        expect(root.present?(11)).to be true
      end

      it 'finds the root.left node using the key' do
        expect(root.present?(5)).to be true
      end

      it 'finds the root.right node using the key' do
        expect(root.present?(13)).to be true
      end

      it 'finds an arbitrary node using the key' do
        expect(root.present?(7)).to be true
      end

      it 'does not find an arbitrary node when the key is not present' do
        expect(root.present?(88)).to be_nil
      end
    end

    describe '.insert' do
      it 'inserts a node' do
        expect(root.right).to eq foo13
        expect(root.left).to eq foo5
        expect(root.left.left).to eq foo2
      end
    end

    describe '.delete' do
      it 'returns the root node when specified for deletion' do
        root = described_class.new 9
        expect(root.delete(9)).to eq root
        expect(root.bst?).to be true
        expect(root.left.nil?).to be true
        expect(root.right.nil?).to be true
      end

      it 'deletes the right node specified by key' do
        root = described_class.new 9
        n14 = described_class.new 14
        root.insert n14
        expect(root.delete(14)).to eq n14
        expect(root.bst?).to be true
        expect(n14.left.nil?).to be true
        expect(n14.right.nil?).to be true
      end

      it 'deletes a right node reassiging that nodes child' do
        root = described_class.new(9)
        n14 = described_class.new(14)
        n23 = described_class.new(23)
        root.insert n14
        root.insert n23
        expect(root.delete(14)).to eq n14
        expect(root.bst?).to be true
        expect(n14.left.nil?).to be true
        expect(n14.right.nil?).to be true
        expect(root.right).to eq n23
        # expect(root.size).to eq 2
      end

      it 'reassigns right subtree on deletion' do
        root = described_class.new(11)
        n17 = described_class.new(17)
        n19 = described_class.new(19)
        n13 = described_class.new(13)
        n5 = described_class.new(5)
        root.insert n17
        root.insert n19
        root.insert n13
        root.insert n5
        expect(root.delete(17)).to eq n17
        expect(root.bst?).to be true
        expect(n17.left.nil?).to be true
        expect(n17.right.nil?).to be true
        expect(root.right).to eq n19
        expect(root.right.left).to eq n13
      end

      it 'rebuilds subtree after deleting node' do
        root = described_class.new(11)
        n5 = described_class.new(5)
        root.insert n5

        n17 = described_class.new(17)
        n13 = described_class.new(13)
        n41 = described_class.new(41)
        n37 = described_class.new(37)
        n31 = described_class.new(31)
        root.insert n17
        root.insert n13
        root.insert n41
        root.insert n37
        root.insert n31
        expect(root.delete(17)).to eq n17
        expect(root.bst?).to be true
        expect(n17.left.nil?).to be true
        expect(n17.right.nil?).to be true
        expect(root.right).to eq n41
        expect(n31.left).to eq n13
        # delete a leaf node
        expect(root.delete(13)).to eq n13
        expect(n31.left).to be_nil
        expect(root.size).to eq 5
      end

      it 'promotes left node on deletion' do
        root = described_class.new 11
        n5 = described_class.new 5
        n7 = described_class.new 7
        n3 = described_class.new 3
        root.insert n5
        root.insert n7
        root.insert n3

        expect(root.delete(5)).to eq n5
        expect(root.bst?).to be true
        expect(n5.left.nil?).to be true
        expect(n5.right.nil?).to be true
        expect(root.left).to eq n3
        expect(n3.right).to eq n7
      end

      it 'deletes the root node correctly' do
        root = described_class.new 11
        n5 = described_class.new 5
        n7 = described_class.new 7
        n3 = described_class.new 3
        root.insert n5
        root.insert n7
        root.insert n3

        n17 = described_class.new 17
        n13 = described_class.new 13
        n41 = described_class.new 41
        n37 = described_class.new 37
        n31 = described_class.new 31
        root.insert n17
        root.insert n13
        root.insert n41
        root.insert n37
        root.insert n31

        expect(root.delete(11)).to eq root
        expect(root.left.nil?).to be true
        expect(root.right.nil?).to be true

        expect(n5.bst?).to be true
        expect(n5.left).to eq n3
        expect(n5.right).to eq n7
        expect(n7.right).to eq n17
      end
    end

    describe '.collect' do
      it 'collects list of keys in correct order' do
        collector = []
        root.collect(collector)
        expect(collector).to eq expected
      end
    end

    describe 'list_keys' do
      it 'lists the keys in correct order' do
        expect(root.list_keys).to eq expected
      end
    end

    describe '.size' do
      it 'finds the size on the fly' do
        expect(root.size).to eq 8
        expect(foo2.size).to eq 2
        expect(foo29.size).to eq 1
      end
    end

    describe '.maximum' do
      it 'finds the node with the largest key' do
        expect(root.maximum).to eq foo29
      end
    end

    describe '.minimum' do
      it 'finds the node with the smallest key' do
        expect(root.minimum).to eq foo2
      end
    end

    describe '.to_hash' do
      it 'creates a hash of the tree' do
        root = described_class.new 10
        n1 = described_class.new 5
        n2 = described_class.new 15
        root.insert n1
        root.insert n2

        expected = {
          uuid: root.uuid,
          key: 10,
          left: {
            uuid: n1.uuid,
            key: 5,
            left: nil,
            right: nil
          },
          right: {
            uuid: n2.uuid,
            key: 15,
            left: nil,
            right: nil
          }
        }
        expect(root.to_hash).to eq expected
      end
    end
  end

  describe '.common_parent' do
    let(:root) { described_class.new 11 }
    let(:n5) { described_class.new 5 }
    let(:n3) { described_class.new 3 }
    let(:n7) { described_class.new 7 }
    let(:n13) { described_class.new 13 }
    let(:n17) { described_class.new 17 }
    let(:n19) { described_class.new 19 }

    it 'finds the common parent to itself' do
      expect(root.common_parent(root, root)).to eq root
    end

    it 'finds the common parent for direct left and right children' do
      root.insert n5
      root.insert n13
      expect(root.common_parent(n5, n13)).to eq root
      expect(root.common_parent(n13, n5)).to eq root
    end

    it 'finds common parent for children on left side of root' do
      root.insert n5
      root.insert n7
      root.insert n3
      expect(root.common_parent(n3, n7)).to eq n5
      expect(root.common_parent(n7, n3)).to eq n5
    end

    it 'finds common parent for nodes in series' do
      root.insert n5
      root.insert n3
      expect(root.common_parent(n3, n5)).to eq n5
      expect(root.common_parent(n5, n3)).to eq n5
    end

    it 'finds common parent for children right of root' do
      root.insert n17
      root.insert n13
      root.insert n19
      expect(root.common_parent(n13, n19)).to eq n17
      expect(root.common_parent(n19, n13)).to eq n17
    end

    it 'finds children either side of root' do
      root.insert n5
      root.insert n7
      root.insert n3
      root.insert n17
      root.insert n13
      root.insert n19
      expect(root.common_parent(n3, n19)).to eq root
      expect(root.common_parent(n19, n3)).to eq root
    end
  end

  describe 'height of tree' do
    it 'finds the height of single node tree' do
      node = described_class.new(9)
      expect(node.height).to eq 0
    end

    it 'finds the height of two node tree with right child' do
      node = described_class.new(9)
      node.insert described_class.new(14)
      expect(node.height).to eq 1
    end

    it 'finds the height of two node tree with left child' do
      node = described_class.new(9)
      node.insert described_class.new(4)
      expect(node.height).to eq 1
    end

    it 'finds the height of three node tree' do
      node = described_class.new(9)
      node.insert described_class.new(14)
      node.insert described_class.new(4)
      expect(node.height).to eq 1
    end

    it 'finds height for arbitrary tree' do
      node = described_class.new(9)
      node.insert described_class.new(14)
      node.insert described_class.new(4)
      node.insert described_class.new(23)
      node.insert described_class.new(5)
      node.insert described_class.new(99)
      node.insert described_class.new(78)
      expect(node.height).to eq 4
    end
  end

  describe 'destroy' do
    it 'destroys root node' do
      root = described_class.new(11)
      root.destroy
      expect(root.left).to be_nil
      expect(root.right).to be_nil
    end

    it 'destroys 3 node tree' do
      root = described_class.new 11
      n7 = described_class.new 7
      n13 = described_class.new 13
      root.insert n7
      root.insert n13
      root.destroy
      expect(root.left).to be_nil
      expect(root.right).to be_nil
    end

    it 'destroys 7 node tree' do
      root = described_class.new 11
      n7 = described_class.new 7
      n5 = described_class.new 5
      n3 = described_class.new 3
      n13 = described_class.new 13
      n17 = described_class.new 17
      n19 = described_class.new 19
      root.insert n7
      root.insert n13
      root.insert n17
      root.insert n19
      root.insert n3
      root.insert n5
      root.destroy
      [root, n5, n17, n7, n13, n19, n3].each do |n|
        expect(n.left).to be_nil
        expect(n.right).to be_nil
      end
    end
  end

  describe 'method overriding' do
    # TODO: Find a lint-compliant way to spec the `include`
    # I spent at least a couple of 30 minute sessions (maybe more)
    # trying to figure out a good way to deal with this
    # situation, and was not able to find a satisfactory
    # solution. Probably, the advice would "well, just don't test
    # test this" but that doesn't sit right, and I'm not sure why.
    # The reading for this went into testing behavior versus
    # implementation, with most of blogistan advising to not test
    # implementation, only behavior. The examples given proved their
    # thesis, but shifted the issue elsewhere. In other words,
    # behavioral testing which assumes the implementation can be just
    # as much an anti-pattern as implementation testing.
    # rubocop:disable Lint/ConstantDefinitionInBlock
    class Bar # rubocop:disable RSpec/LeakyConstantDeclaration
      require 'securerandom'
      include BinarySearchTree
      attr_reader :key, :uuid

      def initialize(key)
        @key = key
        @uuid = SecureRandom.uuid
      end
    end
    # rubocop:enable Lint/ConstantDefinitionInBlock

    it 'fails if comparison operator is not overriden' do
      bar = Bar.new 9
      expect { bar.insert(Bar.new(5)) }.to raise_error(NoMethodError)
    end
  end
end
