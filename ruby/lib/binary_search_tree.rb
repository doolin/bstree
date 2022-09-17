# frozen_string_literal: true

# This module allows any class with a comparable key
# to become a binary search tree node. The tree root
# will need to be managed carefully. I'm not convinced
# it's a good idea to use this, but it works.
#
# TODO: much of the code here is duplicated from Node.
# See if there is a way to extract the duplicate code
# and use this module directly in Node.
# rubocop:disable Metrics/ModuleLength
module BinarySearchTree
  attr_accessor :left, :right

  INCR = 1
  DECR = -1

  def <(_other)
    raise NoMethodError, "'<' method must be overridden"
  end

  def insert(node)
    if node < self
      # TODO: is there a clean, spiffy way to set the parent node here?
      left.nil? ? self.left = node : left.insert(node)
    else
      right.nil? ? self.right = node : right.insert(node)
    end
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def get_successor(node, parent, successor)
    successor = parent if parent&.left == self
    return right.nil? ? successor : right.minimum if node == self

    if node < self
      left&.get_successor node, self, successor
    else
      right&.get_successor node, self, successor
    end
  end
  # rubocop:enable Metrics/PerceivedComplexity
  # rubocop:enable Metrics/CyclomaticComplexity

  def successor(node)
    return nil if node == maximum

    get_successor node, self, node
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def get_predecessor(node, parent, predecessor)
    predecessor = parent if parent&.right == self
    return left.nil? ? predecessor : left.maximum if node == self

    if node < self
      left&.get_predecessor node, self, predecessor
    else
      right&.get_predecessor node, self, predecessor
    end
  end
  # rubocop:enable Metrics/PerceivedComplexity
  # rubocop:enable Metrics/CyclomaticComplexity

  def predecessor(node)
    return nil if node == minimum

    get_predecessor node, self, node
  end

  # rubocop:disable Metrics/MethodLength
  def delete(key, parent = nil)
    node_to_delete, parent = search_with_parent key, parent
    left = node_to_delete.left
    right = node_to_delete.right

    if parent&.right == node_to_delete
      parent&.right = right
      right.insert left unless left.nil?
    else
      parent&.left = left
      left.insert right unless right.nil?
    end

    node_to_delete.left = node_to_delete.right = nil
    node_to_delete
  end
  # rubocop:enable Metrics/MethodLength

  # rubocop:disable Naming/MethodParameterName
  def self.max(l, r)
    l > r ? l : r
  end
  # rubocop:enable Naming/MethodParameterName

  def height
    BinarySearchTree.max(left&.height || -1, right&.height || -1) + 1
  end

  # see if this can be rewritten with `dig` below
  def search_with_parent(key, parent)
    return [self, parent] if key == @key

    key < @key ? left&.search_with_parent(key, self) : right&.search_with_parent(key, self)
  end

  def collect(collector)
    in_order_traverse { |node| collector.push node.key }
    collector
  end

  def list_keys
    collect([])
  end

  # TODO: If possible, rewrite this using `dig` below. Not
  # sure it's possible.
  # rubocop:disable Naming/MethodParameterName
  def common_parent(n1, n2)
    # Probably should enforce n1 < n2 with a swap if necessary.
    if n1 < n2
      l = n1
      r = n2
    else
      l = n2
      r = n1
    end
    # rubocop:enable Naming/MethodParameterName

    return self if l <= self && self <= r

    l < self ? left&.common_parent(l, r) : right&.common_parent(l, r)
  end

  def dig(key, &)
    yield(self)
    key < @key ? left&.dig(key, &) : right&.dig(key, &)
  end

  def search(key)
    dig(key) { |n| return n if n.key == key }
  end

  def present?(key)
    dig(key) { |n| return true if n.key == key }
  end

  # Also see CLR Chapter 13, p. 245
  def bst?
    minimum = -1000
    in_order_traverse do |node|
      return false if minimum >= node.key

      minimum = node.key
      true
    end
  end

  def maximum
    right&.maximum || self
  end

  def minimum
    left&.minimum || self
  end

  def destroy
    post_order_traverse do |node|
      node.left = nil
      node.right = nil
    end
  end

  def size
    size = 0
    post_order_traverse { size += 1 }
    size
  end

  def in_order_traverse(&)
    left&.in_order_traverse(&)
    result = yield(self)
    right&.in_order_traverse(&)
    result
  end

  def pre_order_traverse(&)
    result = yield
    left&.pre_order_traverse(&)
    right&.pre_order_traverse(&)
    result
  end

  def post_order_traverse(&)
    left&.post_order_traverse(&)
    right&.post_order_traverse(&)
    yield(self)
  end

  # Figure out whether there is any way to subclass to_hash
  # such the @uuid and @key is set in the subclass, that is,
  # the including class. That would make this a bit cleaner,
  # it's always nasty having a subclass attribute instance
  # referenced by the module.
  def to_hash
    {
      uuid: @uuid,
      key: @key,
      left: left&.to_hash,
      right: right&.to_hash
    }
  end
end
# rubocop:enable Metrics/ModuleLength
