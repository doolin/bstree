# frozen_string_literal: true

require_relative '../lib/tree'

RSpec.describe Tree do
  let(:node_class) { Tree::NODE_CLASS }

  describe '#invert' do
    subject(:tree) { described_class.new root }

    let(:root) { node_class.new 17 }
    let(:n7) { node_class.new 7 }
    let(:n2) { node_class.new 2 }
    let(:n11) { node_class.new 11 }
    let(:n29) { node_class.new 29 }
    let(:n23) { node_class.new 23 }
    let(:n43) { node_class.new 43 }

    example 'empty tree' do
      tree.delete_by_key root.key
      tree.invert
      expect(tree.empty?).to be true
      expect(tree.preorder_keys).to eq []
    end

    example 'single node' do
      tree.invert
      actual = tree.preorder_keys
      expect(actual).to eq [17]
    end

    context 'when left' do
      example 'child' do
        tree.insert n7
        tree.invert
        expect(root.left).to be_nil
        expect(root.right).to eq n7
      end

      example 'chain' do
        tree.insert n7
        tree.insert n2
        tree.invert
        expect(root.left).to be_nil
        expect(root.right).to be n7
        expect(n7.left).to be_nil
        expect(n7.right).to be n2
      end

      example 'knee' do
        tree.insert n7
        tree.insert n11
        tree.invert
        expect(root.left).to be_nil
        expect(root.right).to be n7
        expect(n7.right).to be_nil
        expect(n7.left).to be n11
      end
    end

    context 'when right' do
      example 'child' do
        tree.insert n29
        tree.invert
        expect(root.right).to be_nil
        expect(root.left).to be n29
      end

      example 'chain' do
        tree.insert n29
        tree.insert n43
        tree.invert
        expect(root.right).to be_nil
        expect(root.left).to be n29
        expect(n29.right).to be_nil
        expect(n29.left).to be n43
      end

      example 'knee' do
        tree.insert n29
        tree.insert n23
        tree.invert
        expect(root.right).to be_nil
        expect(root.left).to be n29
        expect(n29.left).to be_nil
        expect(n29.right).to be n23
      end
    end

    example 'full tree with 3 nodes' do
      tree.insert n7
      tree.insert n29
      tree.invert
      expect(root.right).to be n7
      expect(root.left).to be n29
    end

    example 'full tree with 7 nodes' do
      tree.insert n7
      tree.insert n2
      tree.insert n11
      tree.insert n29
      tree.insert n43
      tree.insert n23
      tree.invert
      expected = [17, 29, 43, 23, 7, 11, 2]
      expect(tree.preorder_keys).to eq expected
    end
  end
end
