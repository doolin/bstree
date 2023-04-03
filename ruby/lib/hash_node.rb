# frozen_string_literal: true

require 'digest'

# Node for a hash tree
class HashNode
  attr_accessor :hash, :key, :left, :right, :parent
end
