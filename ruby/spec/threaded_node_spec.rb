# frozen_string_literal: true

require_relative '../lib/threaded_node'

RSpec.describe ThreadedNode do
  it 'instantiates' do
    expect(described_class.new).not_to be_nil
  end
end
