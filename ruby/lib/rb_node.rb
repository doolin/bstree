# frozen_string_literal: true

require 'node'

# Node class for a Red-Black binary search tree.
class RbNode < Node
  attr_accessor :color

  def initialize(key)
    super
    @color = 'red'
  end

  def insert
    super
    balance
  end

  # We need to balance a red-black tree after
  # inserting a node. Whether the rotation is
  # right or left, and what color the node is
  # needs to be determined next.
  def balance
    # Copilot is able to determine this, but
    # I want to work it out for myself first.
  end
end
