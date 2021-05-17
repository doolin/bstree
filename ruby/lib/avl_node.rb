# frozen_string_literal: true

require 'node'

class AvlNode < Node
  attr_accessor :balance_factor

  def initialize(key)
    super
    @balance_factor = 0
  end

  def insert_nonworking(node)
    super
    node < self ? @weight -= 1 : @weight += 1

    # puts weight
    # if weight >= 2
    #   rotate_cw
    # end
    # super will just insert node.
    # check the current weights here.
    # the hard thing is understanding that the root
    # node may have to change to ensure balance.
  end

  def rotate_right
    parent = self.parent

    pivot = left
    swinger = pivot.right
    self.left = swinger
    swinger&.parent = left
    pivot.right = self
    pivot.parent = parent
    parent&.right = pivot
    pivot.left&.parent = pivot
    self.parent = pivot
  end

  def rotate_left
    parent = self.parent

    pivot = right
    swinger = pivot.left
    self.right = swinger
    swinger&.parent = right
    pivot.left = self
    pivot.parent = parent
    parent&.left = pivot
    pivot.right&.parent = pivot
    self.parent = pivot
  end

  def rotate_left_right
    left.rotate_left
    rotate_right
  end

  def rotate_right_left
    right.rotate_right
    rotate_left
  end

  def right_height
    right.nil? ? 0 : right.height + 1
  end

  def left_height
    left.nil? ? 0 : left.height + 1
  end

  def weight
    right_height - left_height
  end

  def balanced?
    [-1, 0, 1].include? weight
  end

  # TODO: see if this can punt to the parent Node class.
  # Move the relevant tests to shared examples.
  def size
    size = 0
    post_order_traverse { size += 1 }
    size
  end

  def post_order_traverse(&block)
    left&.post_order_traverse(&block)
    right&.post_order_traverse(&block)
    yield
  end
end
