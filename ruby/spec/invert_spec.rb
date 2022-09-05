# frozen_string_literal: true

RSpec.describe Node do
  describe '#invert' do
    it 'nil case unsupported on Node' do
      # this doesn't work with an instance method invert
    end

    it 'base case for single node' do
      tree = Generator.tree1
      tree.root.invert

      aggregate_failures do
        expect(tree.root.left).to be_nil
        expect(tree.root.right).to be_nil
      end
    end

    it 'two node tree with left only swaps to right' do
      tree = Generator.tree2
      tree.root.invert

      aggregate_failures do
        expect(tree.root.left).to be_nil
        expect(tree.root.right.key).to be 7
      end
    end

    it 'two node tree with right only swaps to left' do
      tree = Generator.build([11, 13], 'invert')
      tree.root.invert

      aggregate_failures do
        expect(tree.root.left.key).to be 13
        expect(tree.root.right).to be_nil
      end
    end

    it 'root with left and right nodes swaps children.' do
      tree = Generator.tree213
      tree.root.invert

      aggregate_failures do
        expect(tree.root.left.key).to be 3
        expect(tree.root.right.key).to be 1
      end
    end

    context 'for generated trees reverse sorts the keys' do
      %i[tree1 tree2 tree3 tree4 tree5 tree6 tree7 tree8 tree9 tree10].each do |t|
        example "for #{t}" do
          tree = Generator.send t
          sorted = tree.list_keys
          tree.root.invert

          expect(tree.list_keys).to eq sorted.reverse
        end
      end
    end
  end
end
