# frozen_string_literal: true

RSpec.shared_examples '#maximum' do
  let(:root) { described_class.new 17 }

  before do
    root.insert @node2 = described_class.new(2)
    root.insert @node29 = described_class.new(29)
  end

  it 'finds the minimum node' do
    expect(root.maximum).to eq @node29
  end
end
