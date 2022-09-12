# frozen_string_literal: true

RSpec.shared_examples '#minimum' do
  let(:root) { described_class.new 17 }
  let(:node2) { described_class.new 2 }
  let(:node29) { described_class.new 29 }

  before do
    root.insert node2
    root.insert node29
  end

  it 'finds the minimum node' do
    expect(root.minimum).to eq node2
  end
end
