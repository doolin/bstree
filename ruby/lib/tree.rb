# frozen_string_literal: true

# Tree provides a container and interface for the recursive tree
# data structure. Importantly, Tree keeps track of the current
# root of the data structure, which can change on deletions, or
# balancing, or possibly other operations TBD.
#
# Many if not most of the Tree methods are pass-through, that is,
# the methods send a message to the corresponding method of the
# current root.
#
# rubocop:disable Metrics/ClassLength
class Tree
  attr_reader :root, :size

  # Specifying NODE_CLASS allows subclassing both Tree and Node.
  NODE_CLASS = Node

  def preorder_walk(&)
    return unless root

    root.pre_order_traverse(&)
  end

  def inorder_walk(&)
    return unless root

    root.in_order_traverse(&)
  end

  def postorder_walk(&)
    return unless root

    root.post_order_traverse(&)
  end

  def initialize(node = nil)
    # TODO: find out why both versions pass all
    # the specs. That's bad. One should pass,
    # the other fail.
    # @root = node ? node : NODE_CLASS
    @root = node || NODE_CLASS.new
    @size = 1
  end

  def empty?
    root.nil?
  end

  def set_root_to_nil
    @root = nil
  end

  # TODO: insert tests, shared examples for tree
  # AvlTree needs to call super, then call rebalance.
  # The rebalancing cannot be done via the node insert.
  #
  # @return [Node] implicit, @root is left on the stack
  def insert(node)
    @size += 1
    @root.insert node
  end

  def invert
    return if root.nil?

    preorder_walk do |node|
      temp = node.right
      node.right = node.left
      node.left = temp
    end
  end

  # From CLRS (3rd Edition) p. 296, "transplant" a node's
  # location in the tree. The idea is to replace the deleted node u
  # with its child v, where u and v are the CLRS variable names.
  # This function would be better named `reset_parent` because
  # that's all it does. Resetting child links is done in the
  # delete method.
  def transplant(node, child)
    if node.parent.nil?
      @root = child
    elsif node.left_child?
      node.parent.left = child
    else # right child
      node.parent.right = child
    end

    child&.parent = node.parent
    # return value is given in book, but not used
    # child
  end

  # The variable naming in this method follows CLRS.
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def delete_clrs3(key)
    z = search key
    if z.left.nil?
      transplant z, z.right
    elsif z.right.nil?
      transplant z, z.left
    else
      y = z.right.minimum
      if y.parent != z
        transplant y, y.right
        y.right = z.right
        y.right.parent = y
      end
      transplant z, y
      y.left = z.left
      y.left.parent = y
    end
    @size -= 1
    z.left = z.right = z.parent = nil
    z
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  # This is kind of nasty. It turns out that rooting a tree
  # in some sort of container is both a crutch and a constraint.
  # The big hassle is the edge case induced by deleting the root
  # node.
  def delete(key)
    left = @root.left
    right = @root.right
    deleted_node = @root.delete key
    @size -= 1
    # This is arbitrary, we just pick a side.
    @root = left || right if deleted_node == @root
    deleted_node
  end

  def delete_by_key(key)
    delete_clrs3 key
  end

  def list_keys
    root&.list_keys || []
  end

  def collect(_collector)
    # TODO: file the following for rubocop
    # root&.collect || []
    root&.collect([]) || []
  end

  def preorder_keys
    collector = []
    preorder_walk { |node| collector << node.key }
    collector
  end

  def preorder_balance_factors
    collector = []
    preorder_walk { |node| collector << node.send(:balance_factor) }
    collector
  end

  def postorder_keys
    collector = []
    postorder_walk { |node| collector << node.key }
    collector
  end

  def inorder_keys
    collector = []
    inorder_walk { |node| collector << node.key }
    collector
  end

  def search(key)
    @root.find key
  end

  # From MIT Opencourseware, https://www.youtube.com/watch?v=76dhtgZt38A&list=PLUl4u3cNGP63EdVPNLG3ToM6LaEUuStEY&index=10,
  # the height of a tree is the height of the root. Note: depth of tree is not defined,
  # only depth of nodes. See {Node#depth}
  def height
    root.nil? ? 0 : root.height
  end

  def full?
    root.full?
  end

  def bst?
    root.bst?
  end

  def balanced?
    Node.balanced?(root) != -1
  end

  def successor(node)
    root.successor node
  end

  def predecessor(node)
    root.predecessor node
  end

  def maximum
    @root.maximum
  end

  def minimum
    @root.minimum
  end

  def diameter
    root.diameter
  end

  def to_hash
    root.to_hash
  end

  def to_yml
    require 'yaml'
    to_hash.to_yaml
  end

  def to_yaml_file(filename)
    File.write(filename, to_yml)
  end

  def self.from_yaml_file(filename)
    require 'yaml'
    hashed = YAML.safe_load(File.read(filename))
    from_hash(hashed)
  end

  def to_json(*_args)
    root.to_json
  end

  def to_json_file(filename)
    File.write(filename, root.to_json)
  end

  def self.from_json_file(filename)
    require 'json'
    file = File.read(filename)
    hash = JSON.parse(file)
    from_hash(hash)
  end

  def self.from_hash(hash)
    Tree.new(NODE_CLASS.build_from_hash(hash))
  end

  def get_next_row(current_row)
    next_row = []
    current_row.each do |node|
      next_row << node.left
      next_row << node.right
    end
    next_row.compact
  end

  # TODO: rename to breadth_first_traverse
  # TODO: consider add code to test if root.nil?
  # TODO: rewrite this using a single method with a stack.
  def bfsearch
    rows = [[root]]
    rows << get_next_row(rows.last) until rows.last.empty?
    rows.flatten.map(&:key)
  end
end
# rubocop:enable Metrics/ClassLength
