# frozen_string_literal: true

RSpec.shared_examples '#preorder_walk' do
  describe '#preorder_iterate' do
    subject do
      tree.preorder_walk { |node| nodes << node }
      nodes.map(&:key)
    end

    let(:root) { Node.new 17 }
    let(:nodes) { [] }
    let(:tree) { described_class.new root }

    # let(:root) { Node.new 17 }
    # subject(:tree) { described_class.new root }

    it 'iterates on an empty tree' do
      # tree = described_class.new root
      tree.delete 17
      # expect(tree.preorder_iterate).to eq []
      expect(subject).to eq []
    end

    it 'iterates on a single node tree' do
      expect(subject).to eq [17]
    end

    it 'iterates with left child' do
      tree.insert Node.new 7
      expect(subject).to eq [17, 7]
    end

    it 'iterates with right child' do
      tree.insert Node.new 29
      expect(subject).to eq [17, 29]
    end

    it 'iterates with left and right children' do
      tree.insert Node.new 29
      tree.insert Node.new 7
      expect(subject).to eq [17, 7, 29]
    end

    it 'iterates with left full subtree' do
      tree.insert Node.new 7
      tree.insert Node.new 5
      tree.insert Node.new 3
      expect(subject).to eq [17, 7, 5, 3]
    end

    it 'iterates with right full subtree' do
      tree.insert Node.new 29
      tree.insert Node.new 43
      tree.insert Node.new 19
      expect(subject).to eq [17, 29, 19, 43]
    end

    it 'iterates with degenerate left subtree' do
      tree.insert Node.new 3
      tree.insert Node.new 7
      tree.insert Node.new 11
      tree.insert Node.new 13
      expect(subject).to eq [17, 3, 7, 11, 13]
    end

    it 'iterates with degenerate right subtree' do
      tree.insert Node.new 43
      tree.insert Node.new 29
      tree.insert Node.new 23
      tree.insert Node.new 19
      expect(subject).to eq [17, 43, 29, 23, 19]
    end

    it 'iterates with larger arbitrary tree' do
      tree.insert Node.new 7
      tree.insert Node.new 5
      tree.insert Node.new 2
      tree.insert Node.new 3
      tree.insert Node.new 29
      tree.insert Node.new 43
      tree.insert Node.new 23
      tree.insert Node.new 19
      expect(subject).to eq [17, 7, 5, 2, 3, 29, 23, 19, 43]
    end
  end
end
