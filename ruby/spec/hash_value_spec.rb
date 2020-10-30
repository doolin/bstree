# frozen_string_literal: true

require_relative '../lib/hash_value'

describe HashValue do
  it 'instantiates' do
    data = '1'
    expect(described_class.new(data)).not_to be nil
  end
end
