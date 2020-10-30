# frozen_string_literal: true

require 'spec_helper'

require_relative '../lib/tree'

require 'shared_examples/tree/preorder_walk'
require 'shared_examples/tree/inorder_walk'
require 'shared_examples/tree/postorder_walk'

RSpec.describe Tree do
  it_traverses_with '#preorder_walk'
  it_traverses_with '#inorder_walk'
  it_traverses_with '#postorder_walk'

  let(:node_class) { Tree::NODE_CLASS }

  describe '::NODE_CLASS' do
    it 'returns Node' do
      expect(Tree::NODE_CLASS).to eq Node
    end
  end

  describe '#new' do
    it 'instantiates a root node' do
      node = node_class.new
      expect(tree = Tree.new(node)).not_to be_nil
      expect(tree.root).to eq node
    end
  end

  describe '#size' do
    it 'inserts a node to the tree with existing root' do
      node = node_class.new(1)
      tree = Tree.new node
      node2 = node_class.new(2)
      tree.insert node2
      expect(tree.size).to eq 2

      node3 = node_class.new(3)
      tree.insert node3
      expect(tree.size).to eq 3
    end
  end

  describe '#empty?' do
    it 'returns false when root node is present' do
      root = node_class.new 17
      tree = Tree.new root
      expect(tree.empty?).to be false
    end

    it 'returns true when root node is not present' do
      class Tree
        def set_root_to_nil
          # root is attr_reader
          @root = nil
        end
      end
      tree = Tree.new
      tree.set_root_to_nil
      expect(tree.empty?).to be true
    end
  end

  describe 'tree structure' do
    it 'inserts a node to the tree with existing root' do
      node = node_class.new(10)
      tree = Tree.new node
      tree.insert node_class.new(2)
      expect(tree.size).to eq 2
      expect(tree.root.left.key).to eq 2

      tree.insert node_class.new(33)
      expect(tree.size).to eq 3
      expect(tree.root.right.key).to eq 33

      tree.insert node_class.new(23)
      expect(tree.size).to eq 4
      expect(tree.root.right.left.key).to eq 23
    end
  end

  describe 'successor' do
    it 'finds successor to root node' do
      root = Node.new 13
      tree = Tree.new root
      expect(tree.successor(root)).to be nil
    end
  end

  describe 'predecessor' do
    it 'finds predecessor to root node' do
      root = Node.new 17
      tree = Tree.new root
      expect(tree.predecessor(root)).to eq nil
    end
  end

  describe '.find' do
    it 'finds a node with given key' do
      node = Node.new(9)
      tree = Tree.new node
      tree.insert Node.new(14)
      tree.insert Node.new(4)
      tree.insert Node.new(23)
      tree.insert Node.new(5)
      tree.insert Node.new(99)
      target = Node.new(77)
      tree.insert target
      expect(tree.size).to eq 7
      expect(tree.search(77).object_id).to eq target.object_id
    end
  end

  describe '#height' do
    # Depth should be incremented when nodes are inserted,
    # if the height is to be considered as an attribute of the tree.
    # As a virtual attribute (to borrow a notion from Ruby), calling a
    # tree's height method triggers a traversal of the entire tree to
    # find maximum height. Let's do this first.
    it 'finds the height of single node tree' do
      tree = Tree.new Node.new(9)
      expect(tree.height).to eq 0
    end

    it 'finds the height of two node tree with right child' do
      tree = Tree.new Node.new(9)
      tree.insert Node.new(14)
      expect(tree.height).to eq 1
    end

    it 'finds the height of two node tree with left child' do
      tree = Tree.new Node.new(9)
      tree.insert Node.new(4)
      expect(tree.height).to eq 1
    end

    it 'finds the height of three node tree' do
      tree = Tree.new Node.new(9)
      tree.insert Node.new(14)
      tree.insert Node.new(4)
      expect(tree.height).to eq 1
    end

    it 'finds height for arbitrary tree' do
      node = Node.new(9)
      tree = Tree.new node
      tree.insert Node.new(14)
      tree.insert Node.new(4)
      tree.insert Node.new(23)
      tree.insert Node.new(5)
      tree.insert Node.new(99)
      tree.insert Node.new(78)
      expect(tree.height).to eq 4
    end
  end

  describe '#bst?' do
    let(:root) { Node.new 100 }
    let(:tree) { Tree.new root }

    it 'returns true for binary search tree with 1 node' do
      expect(tree.bst?).to be true
    end
  end

  describe '#full?' do
    let(:root) { Node.new 100 }
    let(:tree) { Tree.new root }
    let(:left) { Node.new 50 }
    let(:right) { Node.new 150 }
    let(:l2) { Node.new 25 }
    let(:l3) { Node.new 75 }
    let(:l4) { Node.new 15 }

    it 'returns true for node with 0 children' do
      expect(root.full?).to be true
    end

    it 'returns true for node with 2 children' do
      tree.insert left
      tree.insert right
      expect(tree.full?).to be true
    end

    it 'returns false for a node with only one child' do
      tree.insert left
      expect(tree.full?).to be false # nil
    end

    it 'returns true for tree with 5 nodes' do
      tree.insert left
      tree.insert right
      tree.insert l2
      tree.insert l3
      expect(tree.full?).to be true
    end

    it 'returns nil for tree with 6 nodes' do
      tree.insert left
      tree.insert right
      tree.insert l2
      tree.insert l3
      tree.insert Node.new 145
      expect(tree.full?).to be_falsy
    end

    it 'returns nil for tree with 6 nodes' do
      tree.insert left
      tree.insert right
      tree.insert l2
      tree.insert l3
      tree.insert l4
      tree.insert Node.new 145
      expect(tree.full?).to be_falsy
    end
  end

  describe 'instance methods' do
    before :all do
      node = Node.new(8, 'uuid8')
      @tree = Tree.new node
      @tree.insert Node.new(14, 'uuid14')
      @tree.insert Node.new(4, 'uuid4')
      @min = Node.new 2, 'uuid2'
      @tree.insert @min
      @tree.insert Node.new(5, 'uuid5')
      @tree.insert Node.new(11, 'uuid11')
      @max = Node.new 21, 'uuid21'
      @tree.insert @max

      @expected = [8, 4, 14, 2, 5, 11, 21]
    end

    describe '.to_hash' do
      it 'creates a hash of the tree' do
        node = Node.new(8)
        nodel = Node.new(4)
        noder = Node.new(14)
        tree = Tree.new node
        tree.insert nodel
        tree.insert noder

        expected = {
          'key' => node.key,
          'uuid' => node.uuid,
          'left' => {
            'key' => nodel.key,
            'uuid' => nodel.uuid,
            'left' => nil,
            'right' => nil
          },
          'right' => {
            'key' => noder.key,
            'uuid' => noder.uuid,
            'left' => nil,
            'right' => nil
          }
        }

        expect(tree.to_hash).to eq expected
      end
    end

    describe '.to_json' do
      it 'creates json representation of tree' do
        root = Node.new(8)
        allow(root).to receive(:uuid).and_return('uuid')
        tree = Tree.new root
        expected = '{"key":8,"uuid":"uuid","left":null,"right":null}'
        expect(tree.to_json).to eq expected
      end
    end

    describe '.to_json_file' do
      it 'writes json to a file' do
        require 'open3'
        filename = 'tree_with_nodes.json'
        @tree.to_json_file "/tmp/#{filename}"
        diff = "diff /tmp/#{filename} spec/output/json/#{filename}"
        output, _status = Open3.capture2e(diff)
        expect(output.empty?).to be true
      end
    end

    describe '.from_json_file' do
      it 'reads from json file' do
        root = Node.new(8)
        tree = Tree.new root
        tree.to_json_file '/tmp/tree.json'

        saved_tree = Tree.from_json_file '/tmp/tree.json'
        expect(saved_tree.root.uuid).to eq tree.root.uuid
      end
    end

    describe '.maximum' do
      it 'finds the node with the largest key' do
        expect(@tree.maximum).to eq @max
      end
    end

    describe '.minimum' do
      it 'finds the node with the smallest key' do
        expect(@tree.minimum).to eq @min
      end
    end

    describe 'breadth first search' do
      it 'performs breadth-first search finds root node' do
        expect(@tree.bfsearch).to eq @expected
      end

      describe 'CLRS 12.1-1 trees of heights 2, 3, 4, 5 and 6' do
        it 'builds tree of height 2' do
          tree = Tree.new Node.new(10)
          tree.insert Node.new(4)
          tree.insert Node.new(17)
          tree.insert Node.new(1)
          tree.insert Node.new(5)
          tree.insert Node.new(16)
          tree.insert Node.new(21)
          expect(tree.height).to eq 2
          expect(tree.bfsearch).to eq [10, 4, 17, 1, 5, 16, 21]
        end

        it 'builds tree of height 3' do
          tree = Tree.new Node.new(5)
          tree.insert Node.new(1)
          tree.insert Node.new(17)
          tree.insert Node.new(4)
          tree.insert Node.new(16)
          tree.insert Node.new(21)
          tree.insert Node.new(10)
          expect(tree.height).to eq 3
          expect(tree.bfsearch).to eq [5, 1, 17, 4, 16, 21, 10]
        end

        it 'builds tree of height 4' do
          tree = Tree.new Node.new(5)
          tree.insert Node.new(1)
          tree.insert Node.new(10)
          tree.insert Node.new(4)
          tree.insert Node.new(16)
          tree.insert Node.new(17)
          tree.insert Node.new(21)
          expect(tree.height).to eq 4
          expect(tree.bfsearch).to eq [5, 1, 10, 4, 16, 17, 21]
        end

        it 'builds tree of height 5' do
          tree = Tree.new Node.new(4)
          tree.insert Node.new(1)
          tree.insert Node.new(5)
          tree.insert Node.new(10)
          tree.insert Node.new(16)
          tree.insert Node.new(17)
          tree.insert Node.new(21)
          expect(tree.height).to eq 5
          expect(tree.bfsearch).to eq [4, 1, 5, 10, 16, 17, 21]
        end

        it 'builds tree of height 6' do
          tree = Tree.new Node.new(1)
          tree.insert Node.new(4)
          tree.insert Node.new(5)
          tree.insert Node.new(10)
          tree.insert Node.new(16)
          tree.insert Node.new(17)
          tree.insert Node.new(21)
          expect(tree.height).to eq 6
          expect(tree.bfsearch).to eq [1, 4, 5, 10, 16, 17, 21]
        end
      end
    end
  end
end
