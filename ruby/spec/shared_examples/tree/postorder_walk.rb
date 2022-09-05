# frozen_string_literal: true

RSpec.shared_examples '#postorder_walk' do
  subject do
    tree.postorder_walk { |node| nodes << node }
    nodes.map(&:key)
  end

  let(:root) { Node.new 17 }
  let(:nodes) { [] }
  let(:tree) { described_class.new root }

  it 'walks an empty tree' do
    tree.delete 17
    expect(subject).to eq []
  end

  it 'iterates with single root node' do
    expect(subject).to eq [17]
  end

  it 'iterates with single left node' do
    tree.insert Node.new 7
    expect(subject).to eq [7, 17]
  end

  it 'iterate with a single right node' do
    tree.insert Node.new 29
    expect(subject).to eq [29, 17]
  end

  it 'iterate with a 4 node full tree' do
    tree.insert Node.new 29
    tree.insert Node.new 7
    expect(subject).to eq [7, 29, 17]
  end

  it 'iterates on a left elbow' do
    tree.insert Node.new 7
    tree.insert Node.new 11
    expect(subject).to eq [11, 7, 17]
  end

  it 'iterates on a right elbow' do
    tree.insert Node.new 29
    tree.insert Node.new 19
    expect(subject).to eq [19, 29, 17]
  end

  it 'iterate with left full subtree' do
    tree.insert Node.new 7
    tree.insert Node.new 3
    tree.insert Node.new 5
    tree.insert Node.new 2
    expect(subject).to eq [2, 5, 3, 7, 17]
  end

  it 'iterate with augmented left full subtree' do
    tree.insert Node.new 7
    tree.insert Node.new 3
    tree.insert Node.new 5
    tree.insert Node.new 2
    tree.insert Node.new 9
    expect(subject).to eq [2, 5, 3, 9, 7, 17]
  end

  it 'iterate with augmented left full subtree' do
    tree.insert Node.new 7
    tree.insert Node.new 3
    tree.insert Node.new 5
    tree.insert Node.new 2
    tree.insert Node.new 9
    tree.insert Node.new 4
    expect(subject).to eq [2, 4, 5, 3, 9, 7, 17]
  end

  it 'iterate with right full subtree' do
    tree.insert Node.new 29
    tree.insert Node.new 43
    tree.insert Node.new 19
    expect(subject).to eq [19, 43, 29, 17]
  end

  it 'iterate with left degenerate subtree' do
    tree.insert Node.new 3
    tree.insert Node.new 5
    tree.insert Node.new 7
    tree.insert Node.new 11
    expect(subject).to eq [11, 7, 5, 3, 17]
  end

  it 'iterate with right degenerate subtree' do
    tree.insert Node.new 43
    tree.insert Node.new 29
    tree.insert Node.new 23
    tree.insert Node.new 19
    expect(subject).to eq [19, 23, 29, 43, 17]
  end

  it 'iterates with larger arbitrary tree' do
    tree.insert Node.new 7
    tree.insert Node.new 3
    tree.insert Node.new 2
    tree.insert Node.new 5
    tree.insert Node.new 13
    tree.insert Node.new 11

    tree.insert Node.new 29
    tree.insert Node.new 43
    tree.insert Node.new 23
    tree.insert Node.new 19
    expect(subject).to eq [2, 5, 3, 11, 13, 7, 19, 23, 43, 29, 17]
  end
end
