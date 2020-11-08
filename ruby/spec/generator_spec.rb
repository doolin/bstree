# frozen_string_literal: true

# TODO: these are documented somewhere, figure out where
# the docs are located.
RSpec.describe Generator do
  it 'builds tree1' do
    tree1 = Generator.tree1
    expect(tree1.size).to eq 1
    expect(tree1.bst?).to be true
    expect(tree1.full?).to be true
    # expect(tree.pathological??).to be false
  end

  it 'builds tree2' do
    tree2 = Generator.tree2
    expect(tree2.size).to eq 2
    expect(tree2.bst?).to be true
    expect(tree2.full?).to be false # nil
    # expect(tree.pathological??).to be false
  end

  it 'builds tree3' do
    tree3 = Generator.tree3
    expect(tree3.size).to eq 3
    expect(tree3.bst?).to be true
    expect(tree3.full?).to be true
    # expect(tree.pathological??).to be false
  end

  it 'builds tree4' do
    tree = Generator.tree4
    expect(tree.size).to eq 3
    expect(tree.bst?).to be true
    expect(tree.full?).to be false # nil
    # expect(tree.pathological??).to be true
  end

  it 'builds tree5' do
    tree = Generator.tree5
    expect(tree.size).to eq 3
    expect(tree.bst?).to be true
    expect(tree.full?).to be false # nil
    # expect(tree.pathological??).to be true
  end

  it 'builds tree6' do
    tree = Generator.tree6
    expect(tree.size).to eq 5
    expect(tree.bst?).to be true
    expect(tree.full?).to be true
    # expect(tree.pathological??).to be true
  end

  it 'builds tree7' do
    tree = Generator.tree7
    expect(tree.size).to eq 5
    expect(tree.bst?).to be true
    expect(tree.full?).to be true
    # expect(tree.pathological??).to be true
  end

  it 'builds tree8' do
    tree = Generator.tree8
    expect(tree.size).to eq 7
    expect(tree.bst?).to be true
    expect(tree.full?).to be true
    # expect(tree.pathological??).to be true
  end

  it 'builds tree9' do
    tree = Generator.tree9
    expect(tree.size).to eq 7
    expect(tree.bst?).to be true
    expect(tree.full?).to be false # nil
    # expect(tree.pathological??).to be true
  end

  it 'builds tree10' do
    tree = Generator.tree10
    expect(tree.size).to eq 10
    expect(tree.bst?).to be true
    expect(tree.full?).to be false # nil
    # expect(tree.pathological??).to be true
  end

  it 'builds tree213' do
    tree = Generator.tree213
    expect(tree.size).to eq 3
    expect(tree.bst?).to be true
    expect(tree.full?).to be true
  end

  it 'builds tree123' do
    tree = Generator.tree123
    expect(tree.size).to eq 3
    expect(tree.bst?).to be true
    expect(tree.full?).to be false
  end

  it 'builds tree132' do
    tree = Generator.tree132
    expect(tree.size).to eq 3
    expect(tree.bst?).to be true
    expect(tree.full?).to be false
  end

  it 'builds tree321' do
    tree = Generator.tree321
    expect(tree.size).to eq 3
    expect(tree.bst?).to be true
    expect(tree.full?).to be false
  end

  it 'builds tree312' do
    tree = Generator.tree312
    expect(tree.size).to eq 3
    expect(tree.bst?).to be true
    expect(tree.full?).to be false
  end
end
