# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RbTree do
  it 'instantiates a new RbTree' do
    expect(described_class.new).to be_a described_class
  end
end
