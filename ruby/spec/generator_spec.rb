# frozen_string_literal: true

# Documented in examples.tex
RSpec.describe Generator do
  it 'builds tree1' do
    tree = Generator.tree1
    expect(tree.size).to eq 1
    expect(tree.height).to eq 0
    expect(tree.bst?).to be true
    expect(tree.full?).to be true
    expect(tree.balanced?).to be true
    expect(tree.postorder_keys).to eq [11]
    expect(tree.preorder_keys).to eq [11]
    # expect(tree1.pathological??).to be false
  end

  it 'builds tree2' do
    tree = Generator.tree2
    expect(tree.size).to eq 2
    expect(tree.height).to eq 1
    expect(tree.bst?).to be true
    expect(tree.full?).to be false
    expect(tree.balanced?).to be true
    expect(tree.postorder_keys).to eq [7, 11]
    expect(tree.preorder_keys).to eq [11, 7]
    # expect(tree.pathological??).to be false
  end

  it 'builds tree3' do
    tree = Generator.tree3
    expect(tree.size).to eq 3
    expect(tree.height).to eq 1
    expect(tree.bst?).to be true
    expect(tree.full?).to be true
    expect(tree.balanced?).to be true
    expect(tree.postorder_keys).to eq [7, 13, 11]
    expect(tree.preorder_keys).to eq [11, 7, 13]
    # expect(tree.pathological??).to be false
  end

  it 'builds tree4' do
    tree = Generator.tree4
    expect(tree.size).to eq 4
    expect(tree.height).to eq 2
    expect(tree.bst?).to be true
    expect(tree.full?).to be false
    expect(tree.balanced?).to be true
    expect(tree.postorder_keys).to eq [3, 7, 13, 11]
    expect(tree.preorder_keys).to eq [11, 7, 3, 13]
    # expect(tree.pathological??).to be true
  end

  it 'builds tree5' do
    tree = Generator.tree5
    expect(tree.size).to eq 5
    expect(tree.height).to eq 2
    expect(tree.bst?).to be true
    expect(tree.full?).to be false
    expect(tree.balanced?).to be true
    expect(tree.postorder_keys).to eq [3, 7, 19, 13, 11]
    expect(tree.preorder_keys).to eq [11, 7, 3, 13, 19]
    # expect(tree.pathological??).to be true
  end

  it 'builds tree6' do
    tree = Generator.tree6
    expect(tree.size).to eq 6
    expect(tree.height).to eq 3
    expect(tree.bst?).to be true
    expect(tree.full?).to be false
    expect(tree.balanced?).to be false
    expect(tree.postorder_keys).to eq [3, 7, 29, 19, 13, 11]
    expect(tree.preorder_keys).to eq [11, 7, 3, 13, 19, 29]
    # expect(tree.pathological??).to be true
  end

  it 'builds tree7' do
    tree = Generator.tree7
    expect(tree.size).to eq 7
    expect(tree.height).to eq 3
    expect(tree.bst?).to be true
    expect(tree.full?).to be false
    expect(tree.balanced?).to be false
    expect(tree.postorder_keys).to eq [5, 3, 7, 29, 19, 13, 11]
    expect(tree.preorder_keys).to eq [11, 7, 3, 5, 13, 19, 29]
    # expect(tree.pathological??).to be true
  end

  it 'builds tree8' do
    tree = Generator.tree8
    expect(tree.size).to eq 8
    expect(tree.height).to eq 3
    expect(tree.bst?).to be true
    expect(tree.full?).to be false
    expect(tree.balanced?).to be false
    expect(tree.postorder_keys).to eq [2, 5, 3, 7, 29, 19, 13, 11]
    expect(tree.preorder_keys).to eq [11, 7, 3, 2, 5, 13, 19, 29]
    # expect(tree.pathological??).to be true
  end

  it 'builds tree9' do
    tree = Generator.tree9
    expect(tree.size).to eq 9
    expect(tree.height).to eq 3
    expect(tree.bst?).to be true
    expect(tree.full?).to be false
    expect(tree.balanced?).to be false
    expect(tree.postorder_keys).to eq [2, 5, 3, 7, 17, 29, 19, 13, 11]
    expect(tree.preorder_keys).to eq [11, 7, 3, 2, 5, 13, 19, 17, 29]
    # expect(tree.pathological??).to be true
  end

  it 'builds tree10' do
    tree = Generator.tree10
    expect(tree.size).to eq 10
    expect(tree.height).to eq 4
    expect(tree.bst?).to be true
    expect(tree.full?).to be false # nil
    expect(tree.balanced?).to be false
    expect(tree.postorder_keys).to eq [2, 5, 3, 7, 17, 23, 29, 19, 13, 11]
    expect(tree.preorder_keys).to eq [11, 7, 3, 2, 5, 13, 19, 17, 29, 23]
    # expect(tree.pathological??).to be true
  end

  context 'trees of size 3' do
    it 'builds tree213' do
      tree = Generator.tree213
      expect(tree.size).to eq 3
      expect(tree.height).to eq 1
      expect(tree.bst?).to be true
      expect(tree.full?).to be true
      expect(tree.balanced?).to be true
      expect(tree.postorder_keys).to eq [1, 3, 2]
    end

    it 'builds tree123' do
      tree = Generator.tree123
      expect(tree.size).to eq 3
      expect(tree.height).to eq 2
      expect(tree.bst?).to be true
      expect(tree.full?).to be false
      expect(tree.balanced?).to be false
      expect(tree.postorder_keys).to eq [3, 2, 1]
    end

    it 'builds tree132' do
      tree = Generator.tree132
      expect(tree.size).to eq 3
      expect(tree.height).to eq 2
      expect(tree.bst?).to be true
      expect(tree.full?).to be false
      expect(tree.balanced?).to be false
      expect(tree.postorder_keys).to eq [2, 3, 1]
    end

    it 'builds tree321' do
      tree = Generator.tree321
      expect(tree.size).to eq 3
      expect(tree.height).to eq 2
      expect(tree.bst?).to be true
      expect(tree.full?).to be false
      expect(tree.balanced?).to be false
      expect(tree.postorder_keys).to eq [1, 2, 3]
    end

    it 'builds tree312' do
      tree = Generator.tree312
      expect(tree.size).to eq 3
      expect(tree.height).to eq 2
      expect(tree.bst?).to be true
      expect(tree.full?).to be false
      expect(tree.balanced?).to be false
      expect(tree.postorder_keys).to eq [2, 1, 3]
    end
  end
end
