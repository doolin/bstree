# frozen_string_literal: true
require_relative './node'

class Tree
  attr_reader :root, :size

  def initialize node = nil
    @root = node ? node : Node.new
    @size = 1
  end

  def add node
    @root.add node
    @size += 1
  end

  def collect
    collector = []
    get_values @root, collector
    collector
  end

  def get_values node, collector
    get_values node.left, collector if node.left
    collector << node.value
    get_values node.right, collector if node.right
  end

  def find key
    @root.find key
  end

  def depth
    @max = 0
    @current = 0
    find_depth root
  end

  def find_depth node
    return if node.nil?

    @current += 1
    find_depth node.left
    find_depth node.right
    @current -= 1
    @max = @max < @current ? @current : @max
  end

  def bfsearch
    _queue = [root]
    collector = []

    collector << root.value

    collector << root.left&.value
    collector << root.right&.value

    collector << root.left&.left&.value
    collector << root.left&.right&.value
    collector << root.right&.left&.value
    collector << root.right&.right&.value

    collector.compact
  end

  def search_bf queue, collector
    current = queue.pop
    collector << current&.value
    queue.push current&.left
    queue.push current&.right
  end
end
