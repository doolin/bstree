# frozen_string_literal: true

require 'spec_helper'

require 'shared_examples/insert'

RSpec.describe AvlNode do
  it_inserts_like 'insertion'

  let(:root) { described_class.new 17 }
  let(:n1) { described_class.new 1 }
  let(:n2) { described_class.new 2 }
  let(:n5) { described_class.new 5 }
  let(:n7) { described_class.new 7 }
  let(:n9) { described_class.new 9 }
  let(:n11) { described_class.new 11 }
  let(:n13) { described_class.new 13 }
  let(:n17) { described_class.new 17 }
  let(:n19) { described_class.new 19 }
  let(:n23) { described_class.new 23 }
  let(:n29) { described_class.new 29 }
  let(:n43) { described_class.new 43 }

  describe '#insert' do
    context 'left heavy tree' do
      it 'computes balance factor after inserting' do
        expect(root.balance_factor).to be 0
        root.insert n7
        expect(root.balance_factor).to be(-1)
        root.insert n13
        expect(root.balance_factor).to be(-2)
        root.insert n11
        expect(root.balance_factor).to be(-3)
      end
    end

    context 'right heavy tree' do
      it 'computes balance factor after inserting' do
        root.insert n29
        expect(root.balance_factor).to be 1
        root.insert n19
        expect(root.balance_factor).to be 2
        root.insert n23
        expect(root.balance_factor).to be 3
      end
    end
  end

  describe '#balance' do
    context 'left heavy' do
      it 'calls right_rot' do
        root.insert n5
        expect(root).to receive(:right_rot)
        # expect(root).to receive(:rotate_right)
        root.insert n2
      end

      it 'calls d_rot_right' do
        root.insert n5
        expect(root).to receive(:d_rot_right)
        root.insert n7
      end
    end

    context 'right heavy' do
      it 'calls left_rot' do
        root.insert n19
        expect(root).to receive(:left_rot)
        root.insert n29
      end

      it 'calls d_rot_left' do
        root.insert n29
        expect(root).to receive(:d_rot_left)
        root.insert n23
      end
    end
  end

  describe '#rotate_left' do
    #   n13             n19
    #     \     ===>   /   \
    #    n19         n13   n23
    #      \
    #     n23
    context 'right chain with 3 nodes' do
      before do
        n13.insert n19
        n13.insert n23
        n13.rotate_left
      end

      it 'remains the same size' do
        expect(n19.size).to eq 3
      end

      it 'has the correct pre-ordering' do
        expected = [19, 13, 23]
        actual = n19.preorder_collect
        expect(actual).to eq expected
      end

      it 'moves the root node to left child' do
        expect(n19.left).to eq n13
        expect(n13.parent).to eq n19
      end

      it 'keeps the right node in place' do
        expect(n19.right).to eq n23
        expect(n23.parent).to eq n19
      end
    end

    #    13                   19
    #   /   \      ===>      /  \
    #  11   19             13    23
    #       /  \          /  \     \
    #     17   23        11   17    43
    #            .
    #            n43
    context 'add node to full subtree' do
      before do
        n13.insert n11
        n13.insert n19
        n13.insert n17
        n13.insert n23
        n13.insert n43
        n13.rotate_left
      end

      it 'remains the same size' do
        expect(n19.size).to be 6
      end

      it 'has the correct preordering' do
        expected = [19, 13, 11, 17, 23, 43]
        actual = n19.preorder_collect
        expect(actual).to eq expected
      end

      it 'moves the old root node to the new root node\'s left child' do
        expect(n13.parent).to be n19
        expect(n19.left).to be n13
      end

      it 'keeps the existing right node in place' do
        expect(n19.right).to be n23
        expect(n23.parent).to be n19
      end

      it 'correctly reassigns swinger node' do
        expect(n13.right).to be n17
        expect(n17.parent).to be n13
      end

      it 'correctly recomputes balance factor' do
        expect(n19.balance_factor).to be 0
        expect(n13.balance_factor).to be 0
      end
    end

    context 'check root parent reassignment for subtree' do
      before do
        n13.insert n19
        n13.insert n23
      end

      #   1
      #    \
      #     n13             n19
      #       \     ===>   /   \
      #      n19         n13   n23
      #        \
      #       n23
      it 'reassigns right child subtree' do
        n1.right = n13
        n13.parent = n1
        n13.rotate_left
        expect(n19.parent).to be n1
        expect(n1.right).to be n19
      end

      #      43             43
      #     /               /
      #   n13             n19
      #     \     ===>   /   \
      #    n19         n13   n23
      #      \
      #     n23
      it 'reassigns left child subtree' do
        n43.left = n13
        n13.parent = n43
        n13.rotate_left
        expect(n19.parent).to be n43
        expect(n43.left).to be n19
      end

      #   nil             nil
      #    |               |
      #   n13             n19
      #     \     ===>   /   \
      #    n19         n13   n23
      #      \
      #     n23
      it 'nil parent parent remains nil' do
        n13.rotate_left
        expect(n19.parent).to be nil
      end
    end
  end

  describe '#rotate_right' do
    #     17            7
    #     /           /   \
    #    7    ===>   5     17
    #   /
    #  5
    context 'left chain with 3 nodes' do
      before do
        n17.insert n7
        n17.insert n5
        n17.rotate_right
      end

      it 'remains the same size' do
        expect(n7.size).to eq 3
      end

      it 'has the correct pre-ordering' do
        expected = [7, 5, 17]
        actual = n7.preorder_collect
        expect(actual).to eq expected
      end

      it 'moves the root node to right child' do
        expect(n7.left).to eq n5
        expect(n7.right).to eq n17
      end

      it 'keeps the left node in place' do
        expect(n5.parent).to eq n7
        expect(n17.parent).to eq n7
      end
    end

    #             17                   11
    #           /    \               /    \
    #         11      29    ==>     5     17
    #       /   \                 /      /   \
    #      5    13               2      13   29
    #     .
    #    2
    context 'add node to full subtree' do
      before do
        n17.insert n11
        n17.insert n29
        n17.insert n5
        n17.insert n13
        n17.insert n2
        n17.rotate_right
      end

      it 'remains the same size' do
        expect(n11.size).to eq 6
      end

      it 'has the correct pre-ordering' do
        expected = [11, 5, 2, 17, 13, 29]
        actual = n11.preorder_collect
        expect(actual).to eq expected
      end

      it 'moves the old root node to the new root node\'s right child' do
        expect(n11.left).to eq n5
        expect(n11.right).to eq n17
      end

      it 'keeps the left node in place' do
        expect(n5.parent).to eq n11
        expect(n17.parent).to eq n11
      end

      it 'correctly reassigns swinger node' do
        expect(n13.parent).to eq n17
        expect(n17.left).to eq n13
      end

      it 'correctly recomputes balance factor' do
        expect(n17.balance_factor).to be 0
        expect(n11.balance_factor).to be 0
      end
    end

    # When a subtree is out of balance, it needs to designate a new root
    # for itself. This is managed in the rotation functions by returning
    # the new root node for appropriate processing by the invoking function.
    context 'check root parent reassignment for subtree' do
      # 3 node subtree suffices.
      before do
        n17.insert n7
        n17.insert n5
      end

      #    1             1
      #     \             \
      #     17            7
      #     /           /   \
      #    7    ===>   5     17
      #   /
      #  5
      it 'reassigns right child subtree' do
        n1.right = n17
        n17.parent = n1
        n17.rotate_right

        expect(n1.right).to eq n7
        expect(n7.parent).to eq n1
      end

      #        43           43
      #       /  \         /  \
      #     17            7
      #     /           /   \
      #    7    ===>   5     17
      #   /
      #  5
      it 'reassigns left child subtree' do
        n43.left = n17
        n17.parent = n43
        n17.rotate_right

        expect(n43.left).to eq n7
        expect(n7.parent).to eq n43
      end

      #     nil          nil
      #      |            |
      #     17            7
      #     /           /   \
      #    7    ===>   5     17
      #   /
      #  5
      it 'nil parent remains nil' do
        n17.rotate_right
        expect(n7.parent).to be nil
      end
    end

    # TODO: document or delete
    it 'rotates clockwise' do
      n17.insert n23
      n17.insert n11
      n17.insert n13
      n17.insert n7

      n17.rotate_right
      expect(n11.right).to eq n17
      expect(n17.left).to eq n13
      expect(n11.size).to eq 5
    end

    # TODO: document that this is an isolated test for a "knee" situation
    context 'left knee' do
      before do
        n17.insert n7
        n17.insert n11
        # NOTE: n7 is the root of the left subtree
        n7.rotate_left
      end

      it 'remains the same size' do
        expect(n17.size).to eq 3
      end

      it 'the "foot" (key=11) node has root parent after rotation' do
        expect(n17.left).to eq n11
        expect(n11.parent).to eq n17
      end

      it 'foot node left is knee node (key=7)' do
        expect(n11.left).to eq n7
        expect(n7.parent).to eq n11
      end

      it 'rotates the root node (key=17) to right child' do
        n17.rotate_right
        expect(n11.size).to eq 3

        actual = n11.preorder_collect
        expected = [11, 7, 17]
        expect(actual).to eq expected
      end
    end
  end

  describe '#rotate_left_right' do
    #      n17             n11
    #     /               /   \
    #    n7     ====>   n7    n17
    #      \
    #      n11
    context 'for simple left knee' do
      before do
        n17.insert n7
        n17.insert n11
        n17.rotate_left_right
      end

      it 'remains the same size' do
        expect(n11.size).to be 3
      end

      it 'has the correct pre-ordering' do
        expected = [11, 7, 17]
        actual = n11.preorder_collect
        expect(actual).to eq expected
      end

      it "moves the old root to the new root's right child" do
        expect(n17.parent).to eq n11
        expect(n11.right).to eq n17
      end

      it "rewrites new root's left child" do
        expect(n7.parent).to eq n11
        expect(n11.left).to eq n7
      end

      it 'correctly computes new balance factors' do
        expect(n11.balance_factor).to be 0
        expect(n17.balance_factor).to be 0
        expect(n7.balance_factor).to be 0
      end
    end

    #      17                 17                11
    #     / \                /  \              /   \
    #    7   29             11  29           7      17
    #   / \      ===>      /  \      ===>   / \    /  \
    #  5   11             7   13           5   9  13  29
    #     / \            / \
    #    9   13         5   9
    context 'left knee with left child' do
      before do
        n17.insert n7
        n17.insert n5
        n17.insert n11
        n17.insert n9
        n17.insert n13
        n17.insert n29
        n17.rotate_left_right
      end

      it 'remains the same size' do
        expect(n11.size).to be 7
      end

      it 'returns the correct preordering' do
        expected = [11, 7, 5, 9, 17, 13, 29]
        actual = n11.preorder_collect
        expect(actual).to eq expected
      end

      it 'keeps the initial pivot left node in place' do
        expect(n11.left).to be n7
        expect(n7.parent).to be n11
      end

      it 'correctly reassigns the swinger node' do
        expect(n17.left).to be n13
        expect(n13.parent).to be n17
      end

      it 'moves the old root node to the new root node\'s right child' do
        expect(n11.right).to be n17
      end

      it 'correctly recomputes balance factors' do
        expect(n11.balance_factor).to be 0
        expect(n17.balance_factor).to be 0
      end

      it 'correctly reassigns parent nodes' do
        expect(n17.parent).to be n11
        expect(n11.parent).to be nil
      end
    end

    context 'check root parent reassignment for subtree' do
      before do
        n17.insert n7
        n17.insert n11
      end

      #     1              1
      #      \              \
      #      n17             n11
      #     /               /   \
      #    n7     ====>   n7    n17
      #      \
      #      n11
      it 'reassigns right child subtree' do
        n1.right = n17
        n17.parent = n1
        n17.rotate_left_right

        expect(n11.parent).to be n1
        expect(n17.parent).to be n11
      end

      #         43              43
      #        /               /
      #      n17             n11
      #     /               /   \
      #    n7     ====>   n7    n17
      #      \
      #      n11
      it 'ressigns left child subtree' do
        n17.parent = n43
        n43.left = n17
        n17.rotate_left_right

        expect(n43.left).to be n11
        expect(n11.parent).to be n43
      end

      #      nil             nil
      #       |               |
      #      n17             n11
      #     /               /   \
      #    n7     ====>   n7    n17
      #      \
      #      n11
      it 'nil parent remains nil' do
        n17.rotate_left_right

        expect(n11.parent).to be nil
        expect(n17.parent).to be n11
      end
    end
  end

  describe '#rotate_right_left' do
    #
    #     n17               n23
    #       \              /   \
    #       n29   ===>   n17   n29
    #      /
    #     n23
    context 'for simple right knee' do
      before do
        n17.insert n29
        n17.insert n23
        n17.rotate_right_left
      end

      it 'subtree remains the same size' do
        expect(n23.size).to be 3
      end

      it 'has correct preordering' do
        expected = [23, 17, 29]
        actual = n23.preorder_collect
        expect(actual).to eq expected
      end

      it 'moves root node to left child' do
        expect(n23.left).to eq n17
        expect(n17.parent).to eq n23
      end

      it 'rewrites the the new subtree root\'s right child' do
        expect(n23.right).to eq n29
        expect(n29.parent).to eq n23
      end

      it 'recomputes balance factors' do
        expect(n17.balance_factor).to be 0
        expect(n23.balance_factor).to be 0
        expect(n29.balance_factor).to be 0
      end
    end

    #       7                   7                   13
    #     /   \               /  \                 /   \
    #    5    19             5   13              7     19
    #        /  \   ===>         / \     ===>   / \    / \
    #       13  43            11   19          5  11  17 43
    #      /  \                   /  \
    #     11   17                17  43
    #
    #
    context 'right knee with right child' do
      before do
        n7.insert n5
        n7.insert n19
        n7.insert n13
        n7.insert n11
        n7.insert n17
        n7.insert n43
        n7.rotate_right_left
      end

      it 'remains the same size' do
        expect(n13.size).to be 7
      end

      it 'has correct preordering' do
        expected = [13, 7, 5, 11, 19, 17, 43]
        actual = n13.preorder_collect
        expect(actual).to eq expected
      end

      it 'keeps the initial subtree right node in place' do
        expect(n19.right).to be n43
        expect(n43.parent).to be n19
      end

      it 'correctly reassigns the right rotation swinger node' do
        expect(n17.parent).to be n19
        expect(n19.left).to be n17
      end

      it 'correctly reassigns the left rotation swinger node' do
        expect(n11.parent).to be n7
        expect(n7.right).to be n11
      end

      it 'moves the old root node to the new root node\'s left child' do
        expect(n7.parent).to be n13
        expect(n13.left).to be n7
      end

      it 'correctly updates balance factors' do
        expect(n7.balance_factor).to be 0
        expect(n13.balance_factor).to be 0
      end

      it 'reassigns parents' do
        expect(n13.parent).to be nil
        expect(n7.parent).to be n13
      end
    end

    context 'check root parent reassignment for subtree' do
      before do
        n17.insert n29
        n17.insert n23
      end

      #    n1                n1
      #     \                 \
      #     n17               n23
      #       \              /   \
      #       n29   ===>   n17   n29
      #      /
      #     n23
      it 'reassigns right child subtree' do
        n17.parent = n1
        n1.right = n17
        n17.rotate_right_left

        expect(n1.right).to be n23
        expect(n23.parent).to be n1
      end

      #       n43               n43
      #       /                 /
      #     n17               n23
      #       \              /   \
      #       n29   ===>   n17   n29
      #      /
      #     n23
      it 'reassigns left child subtree' do
        n43.left = n17
        n17.parent = n43
        n17.rotate_right_left

        expect(n43.left).to be n23
        expect(n23.parent).to be n43
      end

      #     nil               nil
      #      |                 |
      #     n17               n23
      #       \              /   \
      #       n29   ===>   n17   n29
      #      /
      #     n23
      it 'nil parent remains nil' do
        n17.rotate_right_left

        expect(n23.parent).to be nil
        expect(n17.parent).to be n23
      end
    end
  end

  describe '#balanced?' do
    it 'is true for node with 0 children' do
      expect(root.balanced?).to be true
      expect(root.weight).to eq 0
    end

    it 'is true for a node with only left child' do
      root.insert n7
      expect(root.balanced?).to be true
      expect(root.weight).to eq(-1)
    end

    it 'is true for a node with only right child' do
      root.insert n29
      expect(root.balanced?).to be true
      expect(root.weight).to eq 1
    end

    it 'is true for node with left child and right child' do
      root.insert n7
      root.insert n29
      expect(root.balanced?).to be true
      expect(root.weight).to eq 0
    end

    it 'is false for node with left chain' do
      root.insert n7
      root.insert n2
      expect(root.balanced?).to be false
      expect(root.weight).to eq(-2)
      expect(n7.weight).to eq(-1)
    end

    it 'is false for node with left knee' do
      root.insert n7
      root.insert n11
      expect(root.balanced?).to be false
      expect(root.weight).to eq(-2)
      expect(n7.weight).to eq(1)
      expect(root.left.weight).to eq(1)
    end

    it 'is false for node with right chain' do
      root.insert n29
      root.insert n43
      expect(root.balanced?).to be false
      expect(root.weight).to eq 2
      expect(n29.weight).to eq 1
    end

    it 'is false for node with right knee' do
      root.insert n29
      root.insert n19
      expect(root.balanced?).to be false
      expect(root.weight).to eq 2
      expect(n29.weight).to eq(-1)
      expect(root.right.weight).to eq(-1)
    end

    it 'is true for tree with left bell' do
      root.insert n29
      root.insert n7
      root.insert n11
      root.insert n5
      expect(root.balanced?).to be true
      expect(root.weight).to eq(-1)
    end

    it 'is true for tree with right bell' do
      root.insert n7
      root.insert n29
      root.insert n19
      root.insert n43
      expect(root.balanced?).to be true
      expect(root.weight).to eq(1)
    end

    it 'is true for right and left chain at root' do
      expect(root.key).to be 17
      expect(n17.left).to be nil
      expect(n17.right).to be nil

      n17.insert n7
      expect(n17.left_height).to be 1
      n17.insert n19
      expect(n17.balance_factor).to eq(0)

      n17.insert n5
      expect(n17.left_height).to be 2
      n17.insert n29
      expect(n17.balance_factor).to eq(0)

      n17.insert n2
      expect(n5.left).to be n2
      expect(n17.left_height).to be 3

      n17.insert n43
      expect(n17.balance_factor).to eq(0)

      expect(n17.balanced?).to be true
      expect(n17.right_height).to be 3
      expect(n17.left_height).to be 3
      expect(n17.balance_factor).to eq(0)
    end
  end

# rubocop: disable Style/BlockComments
=begin
  describe 'build avl trees from sorted lists' do
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

      # Check to ensure the rotations are getting called
      # correctly.
      #
      # Consider having insert return the current root.
      #
      # expect(n2).to receive(:rotate_left).with("correct argument")
      describe 'only right children' do
        xit 'makes a long right list' do
          n2.insert n3
          n2.insert n5
          expect(n2).to receive(:rotate_right) # .with("correct argument")
          # expect(n2.height).to eq 1
          # expect(n3.height).to eq 0
          # expect(n3.height).to eq 0
          # expect(n2.pathological?).to be false

          # n2.insert n11
          # n2.insert n13
          # n2.insert n17
          # n2.insert n19
          # n2.insert n23
          # n2.insert n29
          # expect(n2.height).to eq 9
          # expect(n29.height).to eq 0
          # expect(n2.pathological?).to be true
          # expect(n29.pathological?).to be false
          # expect(n23.pathological?).to be false
          # expect(n19.pathological?).to be true
          # expect(n2.degenerate?).to be true
        end
      end

      describe 'only left children' do
        xit 'makes a long left list' do
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

      describe 'left and right children, alternately aperiodically' do
        it 'make rubocop happy with example'
      end
    end
  end
=end
  # rubocop:enable Style/BlockComments
end
