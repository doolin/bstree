# frozen_string_literal: true

RSpec.configure do |c|
  c.alias_it_should_behave_like_to :it_finds, ''
end

RSpec.shared_examples '#successor' do
  let(:node) { described_class }
  let(:root) { described_class.new 17 }

  it 'successor of single node is nil' do
    expect(root.successor(root)).to be_nil
  end

  it 'successor of node with right child is right child' do
    root = node.new(11)
    n17 = node.new(17)
    root.insert(n17)
    expect(root.successor(root)).to eq n17
    expect(root.successor(n17)).to be_nil # n17 largest key
  end

  it 'successor of node with only left child is nil' do
    root = node.new(11)
    n5 = node.new(5)
    root.insert(n5)
    # expect(root.successor(root)).to be nil # root is largest element
    expect(root.successor(n5)).to eq root
  end

  it 'successors in short pathological subtree' do
    root = node.new(17)
    n5 = node.new(5)
    n7 = node.new(7)
    n11 = node.new(11)
    n13 = node.new(13)
    root.insert(n5)
    root.insert(n7)
    root.insert(n11)
    root.insert(n13)
    expect(root.successor(n5)).to be n7
    expect(root.successor(n7)).to be n11
    expect(root.successor(n11)).to be n13
    expect(root.successor(n13)).to be root
  end

  it 'finds a successor which is to the right then left' do
    root = node.new 17
    n29 = node.new 29
    n23 = node.new 23
    root.insert n29
    root.insert n23
    expect(root.successor(root)).to eq n23
    expect(root.successor(n23)).to eq n29
    expect(root.successor(n29)).to be_nil
  end

  it 'finds various successors in a tree with some pathological subtrees' do
    root = node.new 17
    n2 = node.new 2
    n3 = node.new 3
    n5 = node.new 5
    n7 = node.new 7
    n11 = node.new 11
    n13 = node.new 13
    n19 = node.new 19
    n23 = node.new 23
    n29 = node.new 29

    root.insert n13
    root.insert n19
    root.insert n23
    root.insert n29
    root.insert n7
    root.insert n11
    root.insert n3
    root.insert n5
    root.insert n2

    expect(root.successor(n2)).to eq n3
    expect(root.successor(n3)).to eq n5
    expect(root.successor(n3)).to eq n5
    expect(root.successor(n5)).to eq n7
    expect(root.successor(n7)).to eq n11
    expect(root.successor(n11)).to eq n13
    expect(root.successor(n13)).to eq root
    expect(root.successor(root)).to eq n19
  end
end
