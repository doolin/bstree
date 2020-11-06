# frozen_string_literal: true

require_relative '../lib/threaded_node'

RSpec.describe ThreadedNode do
  it 'instantiates' do
    expect(ThreadedNode.new).not_to be nil
  end
end
