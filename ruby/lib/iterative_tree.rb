# frozen_string_literal: true

require 'tree'
require 'iterative_node'

class IterativeTree < Tree
  NODE_CLASS = IterativeNode

  def preorder_walk(&)
    preorder_iterate(&)
  end

  def inorder_walk(&)
    inorder_iterate(&)
  end

  def postorder_walk(&)
    postorder_iterate(&)
  end

  # TODO: implement inorder_iterate without a stack,
  # using pointer equality.
  def inorder_iterate
    stack = stack_left

    until stack.empty?
      current = stack.pop
      yield current
      next unless current&.right

      stack << current.right
      # TODO: what's the penalty for this in termsn
      # of object creation?
      stack = stack_left(stack)
    end
  end

  def postorder_iterate
    return unless root

    current = find_unvisited_leaf_node root
    yield current

    while current.has_parent?
      current = find_unvisited_leaf_node current.parent
      yield current
    end
  end

  # TODO: refactor this into something spiffy looking
  # like postorder_iterate.
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/PerceivedComplexity
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/MethodLength
  def preorder_iterate
    return unless root

    stack = [root]
    current = stack.last
    yield current

    until current&.left.nil?
      current = current.left
      yield current
      stack.push current
    end

    until stack.empty?
      current = stack.pop

      next if current&.right.nil?

      current = current.right
      stack.push current
      yield current
      while stack.last&.left
        stack.push stack.last.left
        yield stack.last
      end
    end
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity
  # rubocop:enable Metrics/AbcSize

  def find_leaf_node(current)
    while current.has_children?
      if current.left
        current = current.left
      elsif current.right
        current = current.right
      end
    end
    current
  end

  def find_unvisited_leaf_node(current)
    while current.has_unvisited_children?
      if current.left&.unvisited?
        current = current.left
      elsif current.right&.unvisited?
        current = current.right
      end
    end
    current.visit
  end

  private

  def stack_left(stack = [root])
    stack << stack.last.left while stack.last&.left
    stack
  end
end
