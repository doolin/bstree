# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/iterative_tree'
require_relative '../lib/node'

require 'shared_examples'
require 'preorder_shared_examples'
require 'inorder_shared_examples'
require 'postorder_shared_examples'

RSpec.describe IterativeTree do
  it_behaves_like 'postorder iteration'
  it_behaves_like 'inorder iterate'
  it_behaves_like 'preorder iterate'

  describe '#find_leaf_node' do
    let(:root) { Node.new 17 }
    subject(:tree) { IterativeTree.new root }

    it 'finds self as leaf' do
      expect(tree.find_leaf_node(root)).to eq root
    end

    it 'finds left node as leaf' do
      node7 = Node.new 7
      tree.insert node7
      expect(tree.find_leaf_node(root)).to eq node7
    end

    it 'finds right node as leaf' do
      node29 = Node.new 29
      tree.insert node29
      expect(tree.find_leaf_node(root)).to eq node29
    end

    it 'finds leaf on left elbow' do
      node11 = Node.new 11
      tree.insert Node.new 7
      tree.insert node11
      expect(tree.find_leaf_node(root)).to eq node11
    end

    it 'finds leaf on left subtree' do
      tree.insert Node.new 7
      tree.insert Node.new 2
      tree.insert Node.new 11
      tree.insert Node.new 13
      expect(tree.find_leaf_node(root).key).to eq 2
    end

    it 'finds leaf on right elbow' do
      tree.insert Node.new 29
      node19 = Node.new 19
      tree.insert node19
      expect(tree.find_leaf_node(root)).to eq node19
    end

    it 'finds leaf node on right subtree' do
      tree.insert Node.new 29
      tree.insert Node.new 43
      node53 = Node.new 53
      tree.insert node53
      node19 = Node.new 19
      tree.insert node19
      expect(tree.find_leaf_node(root)).to eq node19
    end
  end

  # TODO: wrap specs in context blocks as necessary to disambiguate
  # testing situations.
  describe '#find_unvisited_leaf_node' do
    let(:root) { Node.new 17 }
    let(:node7) { Node.new 7 }
    let(:node29) { Node.new 29 }

    subject(:tree) { IterativeTree.new root }

    it 'finds self as leaf' do
      expect(tree.find_unvisited_leaf_node(root)).to eq root
    end

    it 'finds left node as leaf' do
      node7 = Node.new 7
      tree.insert node7
      expect(tree.find_unvisited_leaf_node(root)).to eq node7
    end

    it 'finds right node as leaf' do
      node29 = Node.new 29
      tree.insert node29
      expect(tree.find_unvisited_leaf_node(root)).to eq node29
    end

    it 'finds leaf on left elbow' do
      node11 = Node.new 11
      tree.insert Node.new 7
      tree.insert node11
      expect(tree.find_unvisited_leaf_node(root)).to eq node11
    end

    it 'finds leaf on left subtree' do
      tree.insert Node.new 7
      tree.insert Node.new 2
      tree.insert Node.new 11
      tree.insert Node.new 13
      expect(tree.find_unvisited_leaf_node(root).key).to eq 2
    end

    it 'finds leaf on right elbow' do
      tree.insert Node.new 29
      node19 = Node.new 19
      tree.insert node19
      expect(tree.find_unvisited_leaf_node(root)).to eq node19
    end

    it 'finds leaf node on right subtree' do
      tree.insert Node.new 29
      tree.insert Node.new 43
      node53 = Node.new 53
      tree.insert node53
      node19 = Node.new 19
      tree.insert node19
      expect(tree.find_unvisited_leaf_node(root)).to eq node19
    end

    context 'full tree with 3 nodes' do
      it 'finds left leaf node on unvisited 3 node full tree' do
        tree.insert node7
        tree.insert node29
        expect(tree.find_unvisited_leaf_node(root)).to eq node7
      end

      it 'finds left leaf node when right child is visited' do
        tree.insert node7
        tree.insert node29.visit
        expect(tree.find_unvisited_leaf_node(root)).to eq node7
      end

      it 'finds right leaf node unvisited when left is visited' do
        node7.visit
        tree.insert node7
        tree.insert node29
        expect(tree.find_unvisited_leaf_node(root)).to eq node29
      end

      it 'finds root when left and right have been visited' do
        tree.insert node29.visit
        tree.insert node7.visit
        expect(tree.find_unvisited_leaf_node(root)).to eq root
      end
    end

    # TODO: probably some of the above specs can be moved here.
    context 'on degenerate tree' do
      context 'with right chain on left child' do
        it 'finds the first leftmost leaf' do
          tree.insert node7
          tree.insert node2 = Node.new(2)
          tree.insert Node.new 11
          tree.insert Node.new 13
          expect(tree.find_unvisited_leaf_node(root)).to eq node2
        end

        it 'finds the rightmost leaf after first leftmost is visited' do
          tree.insert node7
          tree.insert Node.new(2).visit
          tree.insert Node.new 11
          node13 = Node.new 13
          tree.insert node13
          expect(tree.find_unvisited_leaf_node(root)).to eq node13
        end
      end

      context 'with left chain on right child' do
        it 'finds first leftmost leaf' do
          tree.insert node29
          tree.insert Node.new 23
          tree.insert expected = Node.new(19)
          tree.insert Node.new 43
          expect(tree.find_unvisited_leaf_node(root)).to eq expected
        end

        it 'finds rightmost leaf after all left leaves have been visited' do
          tree.insert node29
          tree.insert Node.new(23).visit
          tree.insert Node.new(19).visit
          tree.insert expected = Node.new(43)
          expect(tree.find_unvisited_leaf_node(root)).to eq expected
        end
      end
    end
  end
end
