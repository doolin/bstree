# frozen_string_literal: true

require 'tree'
require 'avl_node'

# Probably only necessary for typing purposes,
# given typing was used.
class AvlTree < Tree
  def insert(node)
    result = super

    @root = result unless result.nil?
  end
end
