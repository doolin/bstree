# frozen_string_literal: true

# https://en.wikipedia.org/wiki/Lowest_common_ancestor
# https://www.geeksforgeeks.org/lowest-common-ancestor-binary-tree-set-1/

RSpec.describe Node do
  describe '#least_common_ancestor' do
    context 'on tree213 finds' do
      subject(:tree) { Generator.tree213.root }

      it '2 as LCA for 3, 1' do
        expect(tree.lca(3, 1)).to eq 2
      end

      it '2 as LCA for 3, 2' do
        expect(tree.lca(3, 2)).to eq 2
      end

      it '2 as LCA for 1, 2' do
        expect(tree.lca(1, 2)).to eq 2
      end

      # same keys
      it '1 as LCA for 1, 1' do
        expect(tree.lca(1, 1)).to eq 1
      end

      it 'raise KeyNotFoundError if there is no such key in the tree' do
        expect do
          tree.lca(1, 13)
        end.to raise_error(Node::KeyNotFoundError)
      end
    end

    context 'on tree10 finds' do
      subject(:tree) { Generator.tree10.root }

      it '11 as LCA for 2, 23' do
        expect(tree.lca(2, 23)).to be 11
      end

      example '19 as LCA for 17, 23' do
        expect(tree.lca(17, 19)).to be 19
      end
    end
  end
end
