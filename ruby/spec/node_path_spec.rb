# frozen_string_literal: true

RSpec.describe Node do
  describe '#path_to_root' do
    let(:root) { described_class.new 17 }

    it 'handle base case of root' do
      path = root.path_to_root(17, [])
      expect(path).to eq [17]
    end

    it 'handles left hand tree' do
      root.insert described_class.new 5
      key = 5
      path = root.path_to_root(key, [])
      expect(path).to eq [5, 17]
    end

    it 'handles left hand right hand tree' do
      root.insert described_class.new 5
      key = 13
      root.insert described_class.new key
      path = root.path_to_root(key, [])
      expect(path).to eq [13, 5, 17]
    end

    it 'handles right hand tree' do
      root.insert described_class.new 23
      key = 23
      path = root.path_to_root(key, [])
      expect(path).to eq [23, 17]
    end

    it 'handles right hand left hand tree' do
      root.insert described_class.new 23
      root.insert described_class.new 19
      key = 19
      path = root.path_to_root(key, [])
      expect(path).to eq [19, 23, 17]
    end

    it 'use the generator' do
      tree = Generator.tree10
      path = tree.root.path_to_root(23, [])
      expect(path).to eq [23, 29, 19, 13, 11]
    end

    context 'the size 3 trees' do
      it 'finds paths for 213' do
        tree = Generator.tree213
        path = tree.root.path_to_root(1, [])
        expect(path).to eq [1, 2]
        path = tree.root.path_to_root(3, [])
        expect(path).to eq [3, 2]
      end

      it 'find paths for tree123' do
        tree = Generator.tree123
        path = tree.root.path_to_root(2, [])
        expect(path).to eq [2, 1]
        path = tree.root.path_to_root(3, [])
        expect(path).to eq [3, 2, 1]
      end

      it 'find paths for tree132' do
        tree = Generator.tree132
        path = tree.root.path_to_root(3, [])
        expect(path).to eq [3, 1]
        path = tree.root.path_to_root(2, [])
        expect(path).to eq [2, 3, 1]
      end

      it 'find paths for tree321' do
        tree = Generator.tree321
        path = tree.root.path_to_root(1, [])
        expect(path).to eq [1, 2, 3]
        path = tree.root.path_to_root(2, [])
        expect(path).to eq [2, 3]
      end

      it 'find paths for tree312' do
        tree = Generator.tree312
        path = tree.root.path_to_root(1, [])
        expect(path).to eq [1, 3]
        path = tree.root.path_to_root(2, [])
        expect(path).to eq [2, 1, 3]
      end

      it 'handles key not present' do
        tree = Generator.tree312
        expect do
          tree.root.path_to_root(13, [])
        end.to raise_error(Node::KeyNotFoundError)
      end
    end
  end

  describe '#path_to_node' do
    let(:root) { described_class.new 17 }

    it 'handle base case of root' do
      path = root.path_to_node(17, [])
      expect(path).to eq [17]
    end

    it 'handles left hand tree' do
      root.insert described_class.new 5
      key = 5
      path = root.path_to_node(key, [])
      expect(path).to eq [17, 5]
    end

    it 'handles left hand right hand tree' do
      root.insert described_class.new 5
      key = 13
      root.insert described_class.new key
      path = root.path_to_node(key, [])
      expect(path).to eq [17, 5, 13]
    end

    it 'handles right hand tree' do
      root.insert described_class.new 23
      key = 23
      path = root.path_to_node(key, [])
      expect(path).to eq [17, 23]
    end

    it 'handles right hand left hand tree' do
      root.insert described_class.new 23
      root.insert described_class.new 19
      key = 19
      path = root.path_to_node(key, [])
      expect(path).to eq [17, 23, 19]
    end

    it 'use the generator' do
      tree = Generator.tree10
      path = tree.root.path_to_node(23, [])
      expect(path).to eq [11, 13, 19, 29, 23]
    end

    it 'use the generator 10 for key not present' do
      tree = Generator.tree10
      expect do
        tree.root.path_to_node(123, [])
      end.to raise_error(Node::KeyNotFoundError)
    end

    context 'the size 3 trees' do
      it 'finds paths for 213' do
        tree = Generator.tree213
        path = tree.root.path_to_node(1, [])
        expect(path).to eq [2, 1]
        path = tree.root.path_to_node(3, [])
        expect(path).to eq [2, 3]
      end

      it 'find paths for tree123' do
        tree = Generator.tree123
        path = tree.root.path_to_node(2, [])
        expect(path).to eq [1, 2]
        path = tree.root.path_to_node(3, [])
        expect(path).to eq [1, 2, 3]
      end

      it 'find paths for tree132' do
        tree = Generator.tree132
        path = tree.root.path_to_node(3, [])
        expect(path).to eq [1, 3]
        path = tree.root.path_to_node(2, [])
        expect(path).to eq [1, 3, 2]
      end

      it 'find paths for tree321' do
        tree = Generator.tree321
        path = tree.root.path_to_node(1, [])
        expect(path).to eq [3, 2, 1]
        path = tree.root.path_to_node(2, [])
        expect(path).to eq [3, 2]
      end

      it 'find paths for tree312' do
        tree = Generator.tree312
        path = tree.root.path_to_node(1, [])
        expect(path).to eq [3, 1]
        path = tree.root.path_to_node(2, [])
        expect(path).to eq [3, 1, 2]
      end
    end
  end
end
