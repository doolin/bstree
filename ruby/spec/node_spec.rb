# frozen_string_literal: true

require 'shared_examples/insert'
require 'shared_examples/maximum'
require 'shared_examples/minimum'
require 'shared_examples/successor'
require 'shared_examples/predecessor'

RSpec.describe Node do
  it_inserts_like 'insertion'
  it_finds_extremes '#maximum'
  it_finds_extremes '#minimum'
  it_finds '#successor'
  it_finds '#predecessor'

  describe '#depth' do
    context 'when 0' do
      it 'is a single node' do
        node = described_class.new 17
        expect(node.depth).to be 0
      end
    end

    context 'when 1' do
      it 'left child' do
        node = described_class.new 17
        n5 = described_class.new 5
        node.insert n5
        expect(n5.depth).to be 1
      end

      it 'right child' do
        node = described_class.new 17
        n23 = described_class.new 23
        node.insert n23
        expect(n23.depth).to be 1
      end
    end

    context 'when 2' do
      it 'left child' do
        node = described_class.new 17
        n5 = described_class.new 5
        n2 = described_class.new 2
        node.insert n5
        node.insert n2
        expect(n2.depth).to be 2
      end

      it 'right child' do
        node = described_class.new 17
        n23 = described_class.new 23
        node.insert n23
        n29 = described_class.new 29
        node.insert n29
        expect(n29.depth).to be 2
      end
    end
  end

  describe '#list_keys' do
    example 'from single node' do
      node = described_class.new 17
      expect(node.list_keys).to eq [17]
    end

    example 'from several nodes' do
      root = described_class.new 17
      root.insert described_class.new 5
      expect(root.list_keys).to eq [5, 17]
      root.insert described_class.new 23
      expect(root.list_keys).to eq [5, 17, 23]
      root.insert described_class.new 3
      expect(root.list_keys).to eq [3, 5, 17, 23]
      root.insert described_class.new 7
      expect(root.list_keys).to eq [3, 5, 7, 17, 23]
    end
  end

  describe '#collect_post_order' do
    subject(:tree) { root.collect_post_order([]) }

    let(:root) { described_class.new 17 }

    example 'from single node' do
      expect(tree).to eq [17]
    end

    example 'from node with left child' do
      root.insert described_class.new 5
      expect(tree).to eq [5, 17]
    end

    example 'from node with right child' do
      root.insert described_class.new 19
      expect(tree).to eq [19, 17]
    end

    example 'from node with left and right child' do
      root.insert described_class.new 19
      root.insert described_class.new 5
      expect(tree).to eq [5, 19, 17]
    end

    example 'left subtree with degenerate right branch' do
      root.insert described_class.new 7
      root.insert described_class.new 2
      root.insert described_class.new 11
      root.insert described_class.new 13
      expect(tree).to eq [2, 13, 11, 7, 17]
    end

    example 'right subtree with degenerate right tree' do
      root.insert described_class.new 29
      root.insert described_class.new 43
      node53 = described_class.new 53
      root.insert node53
      node19 = described_class.new 19
      root.insert node19
      expect(tree).to eq [19, 53, 43, 29, 17]
    end

    # Now for some overtesting, which is mostly for me to get a
    # clear mental picture of what post-order traverse looks like
    # with data I understand, to wit, sorted primes.
    example 'from node with lots of children' do
      root.insert described_class.new 7
      root.insert described_class.new 3
      root.insert described_class.new 5
      root.insert described_class.new 2
      root.insert described_class.new 13
      root.insert described_class.new 11
      root.insert described_class.new 29
      root.insert described_class.new 43
      root.insert described_class.new 23
      root.insert described_class.new 19
      expect(tree).to eq [2, 5, 3, 11, 13, 7, 19, 23, 43, 29, 17]
    end
  end

  describe '#collect_pre_order' do
    subject(:tree) { root.collect_pre_order([]) }

    let(:root) { described_class.new 17 }

    example 'from single node' do
      expect(tree).to eq [17]
    end

    example 'from left child' do
      root.insert described_class.new 7
      expect(tree).to eq [17, 7]
    end

    example 'from right child' do
      root.insert described_class.new 29
      expect(tree).to eq [17, 29]
    end

    example 'from left and right children' do
      root.insert described_class.new 29
      root.insert described_class.new 7
      expect(tree).to eq [17, 7, 29]
    end

    example 'from node with lots of children' do
      root.insert described_class.new 7
      root.insert described_class.new 3
      root.insert described_class.new 5
      root.insert described_class.new 2
      root.insert described_class.new 13
      root.insert described_class.new 11
      root.insert described_class.new 29
      root.insert described_class.new 43
      root.insert described_class.new 23
      root.insert described_class.new 19
      expect(tree).to eq [17, 7, 3, 2, 5, 13, 11, 29, 23, 19, 43]
    end
  end

  describe '#delete' do
    it 'returns the root node when specified for deletion' do
      root = described_class.new(9)
      expect(root.delete(9)).to eq root
      expect(root.bst?).to be true
      expect(root.left.nil?).to be true
      expect(root.right.nil?).to be true
    end

    it 'deletes the right node specified by key' do
      root = described_class.new(9)
      n14 = described_class.new(14)
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
      expect(root.size).to eq 2
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
      root = described_class.new(11)
      n5 = described_class.new(5)
      n7 = described_class.new(7)
      n3 = described_class.new(3)
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
      root = described_class.new(11)
      n5 = described_class.new(5)
      n7 = described_class.new(7)
      n3 = described_class.new(3)
      root.insert n5
      root.insert n7
      root.insert n3

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

      expect(root.delete(11)).to eq root
      expect(root.left.nil?).to be true
      expect(root.right.nil?).to be true

      expect(n5.bst?).to be true
      expect(n5.left).to eq n3
      expect(n5.right).to eq n7
      expect(n7.right).to eq n17
    end
  end

  describe '#has_children?' do
    let(:tree) { described_class.new 17 }

    example 'root node has no children' do
      expect(tree.has_children?).to be false
    end

    example 'root has left child only' do
      tree.insert described_class.new 7
      expect(tree.has_children?).to be true
    end

    example 'root has right child only' do
      tree.insert described_class.new 29
      expect(tree.has_children?).to be true
    end
  end

  describe '#has_unvisited_children?' do
    let(:tree) { described_class.new 17 }

    example 'root node has no children' do
      expect(tree.has_unvisited_children?).to be false
    end

    context 'with unvisited children' do
      example 'root has unvisited left child only' do
        tree.insert described_class.new 7
        expect(tree.has_unvisited_children?).to be true
      end

      example 'root has unvisited right child only' do
        tree.insert described_class.new 29
        expect(tree.has_unvisited_children?).to be true
      end

      context 'for full tree with both children unvisited' do
        example 'found correctly' do
          tree.insert described_class.new 7
          tree.insert described_class.new 29
          expect(tree.has_unvisited_children?).to be true
        end
      end
    end

    context 'with visited children' do
      example 'left node is visited, right node nil' do
        tree.insert described_class.new(7).visit
        expect(tree.has_unvisited_children?).to be false
      end

      example 'right node is visited, left node nil' do
        tree.insert described_class.new(29).visit
        expect(tree.has_unvisited_children?).to be false
      end
    end

    context 'for full tree with one of the nodes visited' do
      example 'found left node visited' do
        tree.insert described_class.new(7).visit
        tree.insert described_class.new 29
        expect(tree.has_unvisited_children?).to be true
      end

      example 'found right node visited' do
        tree.insert described_class.new(29).visit
        tree.insert described_class.new 7
        expect(tree.has_unvisited_children?).to be true
      end
    end

    context 'for full tree with both left and right child visited' do
      example 'finds both children visited' do
        tree.insert described_class.new(29).visit
        tree.insert described_class.new(7).visit
        expect(tree.has_unvisited_children?).to be false
      end
    end
  end

  describe '#has_parent?' do
    let(:root) { described_class.new 17 }

    example 'is false for root node' do
      expect(root.has_parent?).to be false
    end

    example 'is true when left child' do
      node7 = described_class.new 7
      root.insert node7
      expect(node7.has_parent?).to be true
    end

    example 'is true when right child' do
      node29 = described_class.new 29
      root.insert node29
      expect(node29.has_parent?).to be true
    end
  end

  describe '#left_child?' do
    let(:root) { described_class.new 17 }

    example 'root is not the left child' do
      expect(root.left_child?).to be false
    end

    example 'left child is found correctly' do
      node7 = described_class.new 7
      root.insert node7
      expect(node7.left_child?).to be true
    end

    example 'right child is found correctly' do
      node29 = described_class.new 29
      root.insert node29
      expect(node29.left_child?).to be false
    end
  end

  describe '#right_child?' do
    let(:root) { described_class.new 17 }

    example 'root is not the right child' do
      expect(root.right_child?).to be false
    end

    example 'left child is found correctly' do
      node7 = described_class.new 7
      root.insert node7
      expect(node7.right_child?).to be false
    end

    example 'right child is found correctly' do
      node29 = described_class.new 29
      root.insert node29
      expect(node29.right_child?).to be true
    end
  end

  describe 'comparators' do
    it 'compares keys with <' do
      node1 = described_class.new(1)
      node2 = described_class.new(2)
      expect(node1 < node2).to be true
    end

    it 'compares keys with >=' do
      node1 = described_class.new(1)
      node2 = described_class.new(2)
      expect(node1 >= node2).to be false
    end

    it 'compares keys with >' do
      node1 = described_class.new(1)
      node2 = described_class.new(2)
      expect(node1 > node2).to be false
    end
  end

  describe '.find' do
    it 'a single node finds a key' do
      node1 = described_class.new 2
      node = node1.find 2
      expect(node.object_id).to eq node1.object_id
    end

    it 'finds a key on the left' do
      node1 = described_class.new 2
      node2 = described_class.new 1
      node1.insert node2
      expect(node1.left).to eq node2
      expect(node1.find(1).object_id).to eq node2.object_id
    end

    it 'finds a key on the right' do
      node1 = described_class.new 1
      node2 = described_class.new 2
      node1.insert node2
      expect(node1.right).to eq node2
      expect(node1.find(2).object_id).to eq node2.object_id
    end

    it 'finds a key on the right left' do
      node1 = described_class.new 2
      node2 = described_class.new 4
      node3 = described_class.new 3
      node1.insert node2
      node1.insert node3
      expect(node1.right.left).to eq node3
      expect(node1.find(3).object_id).to eq node3.object_id
    end

    it 'finds a key on the left right' do
      node1 = described_class.new 4
      node2 = described_class.new 2
      node3 = described_class.new 3
      node1.insert node2
      node1.insert node3
      expect(node1.left.right).to eq node3
      expect(node1.find(3).object_id).to eq node3.object_id
    end
  end

  # require_relative 'shared_height_examples'
  describe '.height and size' do
    shared_examples 'height' do
      it 'finds the height of single node tree' do
        root = described_class.new(9)
        expect(root.height).to eq 0
        expect(root.size).to eq 1
      end
    end

    it_has_behavior 'height'

    it 'finds the height of single node tree' do
      root = described_class.new(9)
      expect(root.height).to eq 0
      expect(root.size).to eq 1
    end

    it 'finds the height of two node tree with right child' do
      node = described_class.new(9)
      node.insert described_class.new(14)
      expect(node.height).to eq 1
      expect(node.size).to eq 2
    end

    it 'finds the height of two node tree with left child' do
      node = described_class.new(9)
      node.insert described_class.new(4)
      expect(node.height).to eq 1
      expect(node.size).to eq 2
    end

    it 'finds the height of three node tree' do
      node = described_class.new(9)
      node.insert described_class.new(14)
      node.insert described_class.new(4)
      expect(node.height).to eq 1
      expect(node.size).to eq 3
    end

    it 'finds the height of four node tree with two left children' do
      node = described_class.new(9)
      node.insert described_class.new(14)
      node.insert described_class.new(4)
      node.insert described_class.new(2)
      expect(node.height).to eq 2
      expect(node.size).to eq 4
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
      expect(node.size).to eq 7
    end
  end

  describe 'present?' do
    it 'indicates whether a node is present' do
      root = described_class.new 4
      node2 = described_class.new 2
      node3 = described_class.new 3
      node4 = described_class.new 9
      root.insert node2
      root.insert node3
      root.insert node4
      expect(root.present?(4)).to be true
      expect(root.present?(2)).to be true
      expect(root.present?(3)).to be true
      expect(root.present?(9)).to be true
      expect(root.present?(8)).to be false
    end
  end

  describe '.bst?' do
    let(:root) { described_class.new 17 }

    it 'returns true for tree with one node' do
      expect(root.bst?).to be true

      n5 = described_class.new 5
      n23 = described_class.new 23
      root.insert n5
      root.insert n23
      expect(root.bst?).to be true

      n7 = described_class.new 7
      n29 = described_class.new 29
      n23.insert n7
      n23.insert n29
      expect(n23.bst?).to be true
      expect(root.bst?).to be false
    end
  end

  describe '.balanced?' do
    let(:root) { described_class.new 17 }

    context 'true when' do
      it 'single node' do
        expect(described_class.balanced?(root)).to be 1
      end

      it 'single left child' do
        root.insert described_class.new 11
        expect(described_class.balanced?(root)).to be 2
      end

      it 'single right child' do
        root.insert described_class.new 23
        expect(described_class.balanced?(root)).to be 2
      end

      it 'left and right child' do
        root.insert described_class.new 23
        root.insert described_class.new 11
        expect(described_class.balanced?(root)).to be 2
      end
    end

    context 'false when' do
      it 'two right nodes' do
        root.insert described_class.new 23
        root.insert described_class.new 29
        expect(root.size).to be 3
        expect(described_class.balanced?(root)).to be(-1)
      end

      it 'two left nodes' do
        root.insert described_class.new 11
        root.insert described_class.new 7
        expect(described_class.balanced?(root)).to be(-1)
      end

      it 'full tree left weighted' do
        root.insert described_class.new 19
        root.insert described_class.new 15
        root.insert described_class.new 13
        root.insert described_class.new 12
        root.insert described_class.new 16
        root.insert described_class.new 14
        expect(described_class.balanced?(root)).to be(-1)
      end
    end
  end

  describe '.full?' do
    let(:root) { described_class.new 100 }
    let(:left) { described_class.new 50 }
    let(:right) { described_class.new 150 }
    let(:l2) { described_class.new 25 }
    let(:l3) { described_class.new 75 }

    it 'returns true for node with 0 children' do
      expect(root.full?).to be true
    end

    it 'returns true for node with 2 children' do
      root.insert left
      root.insert right
      expect(root.full?).to be true
    end

    it 'returns false for a node with only one child' do
      root.insert left
      expect(root.full?).to be false # nil
    end

    it 'returns true for tree with 5 nodes' do
      root.insert left
      root.insert right
      root.insert l2
      root.insert l3
      expect(root.full?).to be true
    end
  end

  describe '.to_a' do
    it 'returns an array of representing the node and children' do
      root = described_class.new 3
      left = described_class.new 2
      right = described_class.new 4
      root.insert left
      root.insert right
      expected = [root.key, left.uuid, right.uuid]
      expect(root.to_a).to eq expected
    end

    it 'deals with leaf nodes correctly' do
      node1 = described_class.new 4
      node2 = described_class.new 2
      node3 = described_class.new 3
      node1.insert node2
      node1.insert node3
      expected = [node1.key, node2.uuid, nil]
      expect(node1.to_a).to eq expected
    end
  end

  describe '.to_hash' do
    it 'creates a hash of the tree' do
      node = described_class.new(8)
      nodel = described_class.new(4)
      noder = described_class.new(14)
      node.insert nodel
      node.insert noder

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

      expect(node.to_hash).to eq expected
    end
  end

  describe 'build_from_hash' do
    it 'builds a tree from a root node with single hashe' do
      node = described_class.new(8)
      new_node = described_class.build_from_hash node.to_hash
      expect(new_node.uuid).to eq node.uuid
      expect(new_node.key).to eq node.key
    end

    it 'builds a tree from a root node nested hashes' do
      root = described_class.new(8)
      left = described_class.new(4)
      right = described_class.new(14)
      root.insert left
      root.insert right
      new_node = described_class.build_from_hash root.to_hash
      expect(new_node.uuid).to eq root.uuid
      expect(new_node.key).to eq root.key
      expect(new_node.left.uuid).to eq left.uuid
      expect(new_node.left.key).to eq left.key
      expect(new_node.right.uuid).to eq right.uuid
      expect(new_node.right.key).to eq right.key
    end
  end

  describe '.to_json' do
    it 'creates a json representation of the node' do
      node = described_class.new(8)
      allow(node).to receive(:uuid).and_return('uuid')
      expected = '{"key":8,"uuid":"uuid","left":null,"right":null}'
      expect(node.to_json).to eq expected
    end
  end

  describe 'various pathological trees' do
    describe 'trees as linked lists' do
      let(:n2) { described_class.new 2 }
      let(:n3) { described_class.new 3 }
      let(:n5) { described_class.new 5 }
      let(:n7) { described_class.new 7 }
      let(:n11) { described_class.new 11 }
      let(:n13) { described_class.new 13 }
      let(:n17) { described_class.new 17 }
      let(:n19) { described_class.new 19 }
      let(:n23) { described_class.new 23 }
      let(:n29) { described_class.new 29 }

      describe 'only right children' do
        it 'makes a long right list' do
          n2.insert n3
          n2.insert n5
          n2.insert n7
          n2.insert n11
          n2.insert n13
          n2.insert n17
          n2.insert n19
          n2.insert n23
          n2.insert n29
          expect(n2.height).to eq 9
          expect(n29.height).to eq 0
          # expect(n2.pathological?).to be true
          # expect(n29.pathological?).to be false
          # expect(n23.pathological?).to be false
          # expect(n19.pathological?).to be true
          # expect(n2.degenerate?).to be true
        end
      end

      describe 'only left children' do
        it 'makes a long left list' do
          n29.insert n23
          n29.insert n19
          n29.insert n17
          n29.insert n13
          n29.insert n11
          n29.insert n7
          n29.insert n5
          n29.insert n3
          n29.insert n2
          expect(n29.height).to eq 9
          expect(n2.height).to eq 0
          # expect(n29.pathological?).to be true
          # expect(n5.pathological?).to be true
          # expect(n3.pathological?).to be false
          # expect(n29.degenerate?).to be true
        end
      end

      describe 'left and right children, alternately aperiodically'
    end
  end
end
