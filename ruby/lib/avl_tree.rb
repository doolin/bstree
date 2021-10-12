# frozen_string_literal: true

require 'tree'
require 'avl_node'

class AvlTree < Tree
  def insert(node)
    result = super

    @root = result unless result.nil?
  end
end
