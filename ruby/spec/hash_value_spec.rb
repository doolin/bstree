# frozen_string_literal: true

RSpec.describe HashValue do
  it 'instantiates' do
    data = '1'
    expect(described_class.new(data)).not_to be_nil
  end
end
