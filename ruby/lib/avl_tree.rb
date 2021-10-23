# frozen_string_literal: true

require 'tree'
require 'avl_node'

class AvlTree < Tree
  def initialize(node)
    super
    root.balance_factor = 0
  end

  def insert(node)
    super
    retrace node
  end

  # rubocop:disable  Metrics/MethodLength
  def rotate_left(node, rotation_root)
    # binding.break # if node.key == 23
    # puts "rotate_left node.key: #{node.key}, node.balance_factor: #{node.balance_factor},\
    #   rotation_root.key: #{rotation_root.key},
    #   rotation_root.balance_factor: #{rotation_root.balance_factor}"
    if node.balance_factor.negative?
      node.rotate_right
      node.balance_factor += 1
      node = rotation_root.right
      node.balance_factor += 1
    end
    pivot = rotation_root.rotate_left
    rotation_root.balance_factor -= 1
    pivot.balance_factor -= 1
    @root = pivot if @root == rotation_root
    pivot.parent
  end

  def rotate_right(node, rotation_root)
    # puts "rotate_right node.key: #{node.key}, node.balance_factor: #{node.balance_factor},\
    #   rotation_root.key: #{rotation_root.key},
    #   rotation_root.balance_factor: #{rotation_root.balance_factor}"
    if node.balance_factor.positive?
      node.rotate_left
      node.balance_factor -= 1
      node = rotation_root.left
      node.balance_factor -= 1
    end
    pivot = rotation_root.rotate_right
    rotation_root.balance_factor += 1
    pivot.balance_factor += 1
    @root = pivot if @root == rotation_root
    pivot.parent
  end
  # rubocop:enable  Metrics/MethodLength

  # TODO: try to get rid of this method
  def balance_right(node)
    # binding.break if node.key == 23
    parent = node.parent
    return rotate_left(node, parent) if parent.balance_factor.positive?

    parent.balance_factor += 1
    node.parent
  end

  # TODO: try to get rid of this method
  def balance_left(node)
    parent = node.parent
    return rotate_right(node, parent) if parent.balance_factor.negative?

    parent.balance_factor -= 1
    node.parent
  end

  # TODO: try to get rid of this method
  def balance(node)
    # binding.break # if node.key == 23
    node.right_child? ? balance_right(node) : balance_left(node)
  end

  # TODO: try to get rid of this method
  def retrace(node)
    parent = node.parent
    until parent.nil?
      node = balance(node)
      parent = node&.parent
    end
  end
end
