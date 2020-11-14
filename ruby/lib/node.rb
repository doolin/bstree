# frozen_string_literal: true

require 'securerandom'
require 'csv'

class NodeCsvWriter
  def initialize(node)
    [node.key, node.left.uuid, node.right.uuid]
  end
end

class Node
  class KeyNotFoundError < ::StandardError
  end

  attr_accessor :parent, :left, :right, :uuid, :key, :visited

  INCR = 1
  DECR = -1

  def initialize(key = nil, uuid = nil)
    @key = key
    @visited = false
    @uuid = uuid || SecureRandom.uuid
  end

  def <(other)
    @key < other.key
  end

  def >=(other)
    @key >= other.key
  end

  def >(other)
    @key > other.key
  end

  def insert(node)
    node < self ? insert_left(node) : insert_right(node)
  end

  def insert_left(node)
    if @left.nil?
      node.parent = self
      @left = node
    else
      @left.insert(node)
    end
  end

  def insert_right(node)
    if @right.nil?
      node.parent = self
      @right = node
    else
      @right.insert(node)
    end
  end

  # TODO: see if this can be handled with find and a block,
  # implement the block first.
  # https://doolin.atlassian.net/browse/BST-35
  def get_predecessor(node, parent, predecessor)
    predecessor = parent if right_child?
    return left.nil? ? predecessor : left.maximum if node == self

    if node < self
      left&.get_predecessor node, self, predecessor
    else
      right&.get_predecessor node, self, predecessor
    end
  end

  def predecessor(node)
    return nil if node == minimum # yuck

    get_predecessor node, self, node
  end

  # https://doolin.atlassian.net/browse/BST-35
  def get_successor(node, parent, successor)
    successor = parent if left_child?
    return right.nil? ? successor : right.minimum if node == self

    if node < self
      left&.get_successor node, self, successor
    else
      right&.get_successor node, self, successor
    end
  end

  def successor(node)
    # Horrible, horrible kludge
    return nil if node == maximum

    get_successor node, self, node
  end

  def visited?
    @visited
  end

  # rubocop:disable Naming/MethodParameterName
  def self.max(l, r)
    l > r ? l : r
  end
  # rubocop:enable Naming/MethodParameterName

  def height
    # This check makes the ABC and cyclomatic complexity of this method
    # too high. May need to disable for just this method
    # raise if left && left == self || right && right == self # stack overflow
    self.class.max(left&.height || -1, right&.height || -1) + 1
  end

  # TODO: this method could almost surely be refactored into
  # something smaller and more literate.
  # rubocop:disable Metrics/MethodLength
  def delete(key, parent = nil)
    node_to_delete, parent = find_with_parent key, parent
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

  # TODO: refactor to use a block, then with find.
  # https://doolin.atlassian.net/browse/BST-36
  def find_with_parent(key, parent)
    return [self, parent] if key == @key

    key < @key ? left&.find_with_parent(key, self) : right&.find_with_parent(key, self)
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  def find(key, &block)
    yield(self) if block_given?

    # We may not actually care about the returned node, but if we
    # want to generalize `find` this method needs to work if the
    # node is returned. Also, if there is no node with the associated
    # key, the `find` will return nil, which can be raised as a
    # KeyNotFoundError
    return self if key == @key

    key < @key ? left&.find(key, &block) : right&.find(key, &block)
  end
  # rubocop:enable Metrics/CyclomaticComplexity

  def path_to_node(key, collector)
    node = find(key) { |n| collector << n.key }
    raise KeyNotFoundError if node.nil?

    collector
  end

  def path_to_root(key, collector)
    path_to_node(key, collector).reverse
  end

  def present?(key)
    find(key) ? true : false
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  def balanced?
    left_height = left&.height || 0
    right_height = right&.height || 0
    return false unless [-1, 0, 1].include?(left_height - right_height)

    left&.balanced?
    right&.balanced?
    true
  end
  # rubocop:enable Metrics/CyclomaticComplexity

  def full?
    return true if left.nil? && right.nil?

    left&.full? && right&.full? || false # returns nil instead of false, why?
  end

  def bst?
    minimum = -10_000 # fixme
    in_order_traverse do |node|
      return false if minimum >= node.key

      minimum = node.key
      true
    end
  end

  # rubocop:disable Naming/PredicateName
  def has_children?
    left || right ? true : false # would otherwise return the node or nil
  end
  # rubocop:enable Naming/PredicateName

  def visit
    @visited = true
    self
  end

  def unvisited?
    !visited
  end

  # rubocop:disable Naming/PredicateName
  def has_unvisited_children?
    return false unless has_children?

    left&.unvisited? || right&.unvisited? ? true : false
  end
  # rubocop:enable Naming/PredicateName

  # TODO: write out why I have an issue with what rubocop
  # demands here. Rubocop demands the `has` to be removed
  # from predicate method names. I don't agree with this
  # in all cases as `is` and `has` are not the same sort
  # of thing. Restricting the predicate names from `is`
  # seems fine. Using `has` forces a point of view which
  # is very helpful for readability. It puts the reader
  # in the correct perspective, the perspective does not
  # need to be inferred or implied. For example, `is_parent`
  # and `has_parent` have very different meanings. What
  # does a method named `parent?` mean? Here, we want to
  # ask the node whether it has a parent, because if it
  # does not, it's the root node, and that's a special
  # case. Conversely, if the node is not a parent, it's
  # a leaf node, another special case.
  # rubocop:disable Naming/PredicateName
  def has_parent?
    !parent.nil?
  end
  # rubocop:enable Naming/PredicateName

  def right_child?
    self == parent&.right
  end

  def left_child?
    self == parent&.left
  end

  def maximum
    right&.maximum || self
  end

  def minimum
    left&.minimum || self
  end

  def collect_pre_order(collector)
    pre_order_traverse { |node| collector << node.key }
  end

  def collect(collector)
    in_order_traverse { |node| collector << node.key }
  end

  def collect_post_order(collector)
    post_order_traverse { |node| collector << node.key }
  end

  def list_keys
    collect []
  end

  def preorder_collect
    collect_pre_order []
  end

  # TODO: this should be the same with any traverse, each should
  # visit every node once.
  def size
    size = 0
    post_order_traverse { size += 1 }
    size
  end

  def in_order_traverse(&block)
    left&.in_order_traverse(&block)
    result = yield(self)
    right&.in_order_traverse(&block)
    result
  end

  def post_order_traverse(&block)
    left&.post_order_traverse(&block)
    right&.post_order_traverse(&block)
    yield(self)
  end

  def pre_order_traverse(&block)
    result = yield(self)
    left&.pre_order_traverse(&block)
    right&.pre_order_traverse(&block)
    result
  end

  def self.build_from_hash(params)
    return nil if params.nil?

    node = new(params['key'], params['uuid'])
    node.left = build_from_hash(params['left'])
    node.right = build_from_hash(params['right'])
    node
  end

  def to_hash
    {
      'key' => key,
      'uuid' => uuid,
      'left' => left&.to_hash,
      'right' => right&.to_hash
    }
  end

  def to_json(*_args)
    require 'json'
    to_hash.to_json
  end

  def to_a
    [key, @left&.uuid, @right&.uuid]
  end
end
