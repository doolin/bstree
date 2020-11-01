# frozen_string_literal: true

require 'digest'

# This class needs to support creating data, but also
# retrieving data.
class HashValue
  attr_accessor :hash, :data, :parent, :left, :right

  def initialize(data)
    @data = data
  end
end
