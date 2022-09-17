# frozen_string_literal: true

require 'node'

# Iteration has its uses, usually when recursion induces
# an unacceptable performance penalty. Here's an iterative
# take on binary search tree.
class IterativeNode < Node
  def insert(node)
    current = self

    loop do
      if node < current
        current.left.nil? ? insert_left(current, node) && break : current = current.left
      else
        current.right.nil? ? insert_right(current, node) && break : current = current.right
      end
    end
  end

  def maximum
    max = self
    max = max.right while max.right
    max
  end

  def minimum
    min = self
    min = min.left while min.left
    min
  end

  def predecessor(node)
    return node.left.maximum if node.left

    find_predecessor node
  end

  def successor(node)
    return node.right.minimum if node.right

    find_successor node
  end

  private

  def insert_left(current, node)
    node.parent = current
    current.left = node
  end

  def insert_right(current, node)
    node.parent = current
    current.right = node
  end

  # SMELL: This is ugly, but a couple hours banging
  # on it didn't find any elegance.
  # What's happening is traversing up the parent
  # pointers until the node is left child of the parent.
  # This is worth revisiting, there is a cleaner function here
  # somewhere, and I'd like to extract it.
  def find_successor(node)
    y = node.parent
    while !y.nil? && node.right_child?
      node = y
      y = y.parent
    end
    y
  end

  def find_predecessor(node)
    y = node.parent
    while !y.nil? && node == y.left
      node = y
      y = y.parent
    end
    y
  end
end
