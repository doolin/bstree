# frozen_string_literal: true

require 'node'

# Create left and right links by calls to successor or
# predecessor
class ThreadedNode < Node
  attr_accessor :left, :right
end
