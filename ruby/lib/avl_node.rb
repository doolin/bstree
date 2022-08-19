# frozen_string_literal: true

require 'node'

class AvlNode < Node
  attr_writer :balance_factor

  def initialize(key)
    super
    @balance_factor = 0
  end

  def insert(node)
    super
    balance_node
  end

  # rubocop:disable  Metrics/MethodLength
  def balance_node
    @balance_factor = weight

    if @balance_factor < -1
      if left.balance_factor == 1
        rotate_left_right
      else
        rotate_right
      end
    elsif @balance_factor > 1
      if right.balance_factor == -1
        rotate_right_left
      else
        rotate_left
      end
    end
  end
  # rubocop:enable  Metrics/MethodLength

  # I believe this and the rotate_left methods are probably correct.
  # The challenge is that after the rotation, there may be a new subtree
  # root, which may be the root of the entire tree as well. This case is
  # not covered by any of the literature, and frankly is the more
  # interesting aspect of the implementation from an engineering perspective.
  #
  #             17                   11
  #           /    \               /    \
  #         11      29    ==>     5     17
  #       /   \                 /      /   \
  #      5    13               2      13   29
  #     .
  #    2
  #
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  # @return [AvlNode] the new subtree root
  def rotate_right
    parent = self.parent       # might be nil if actual root of whole tree

    pivot = left               # pivot is going to be the new subtree root
    swinger = pivot.right      # this might be nil
    self.left = swinger        # self is the old subtree root
    swinger&.parent = self # left     # if swinger is nil, its parent is of course nil

    pivot.right = self         # the right child of the new subtree root is the old subtree root
    pivot.parent = parent      # reset the parent for the new subtree root, might be nil
    # We need to know if the old subtree root is a left child or a right child
    # so that if it exists, we can set the new subtree root correctly. Until it's reset, it
    # should be pointing at the `self`, the old subtree root.
    unless parent.nil?
      if right_child?
        parent.right = pivot # if there is a parent, its right child is the new subtree root
      else
        parent.left = pivot
      end
    end

    self.parent = pivot        # the old subtree root gets the new subtree root as a parent

    balance_factor             # rebalance self
    pivot.balance_factor       # rebalance pivot
    pivot                      # return pivot as new subtree root
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  # When the balance factor is greater than 1, the tree is out of
  # balance to the right and needs to rotate left.
  #
  #    13                   19
  #   /   \      ===>      /  \
  #  11   19             13    23
  #       /  \          /  \     \
  #     17   23        11   17    43
  #            .
  #            n43
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  #
  # @return [AvlNode] the new subtree root
  def rotate_left
    parent = self.parent # might be nil if actual root of whole tree

    pivot = right              # pivot will be new subtree root
    swinger = pivot.left       # this might be nil
    self.right = swinger       # self is the old subtree root
    swinger&.parent = self     # if swinger is nil, its parent is of course nil

    pivot.left = self          # the left child of the new subtree root is the old subtree root
    pivot.parent = parent      # reset the parent for the new subtree root, might be nil

    # seems to be required for "knee"
    # parent&.left = pivot
    unless parent.nil?
      if right_child?
        parent.right = pivot # if there is a parent, its right child is the new subtree root
      else
        parent.left = pivot
      end
    end

    self.parent = pivot        # the old subtree root gets the new subtree root as a parent

    balance_factor             # rebalance self
    pivot.balance_factor       # rebalance pivot
    pivot                      # return pivot as new subtree root
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  # Here is the general case, which won't occur when balancing on insertion,
  # but could occur as a result some operation such as a deletion of a child
  # node for node 29.
  #
  #      17                 17                11
  #     / \                /  \              /   \
  #    7   29             11  29           7      17
  #   / \      ===>      /  \      ===>   / \    /  \
  #  5   11             7   13           5   9  13  29
  #     / \            / \
  #    9   13         5   9
  #
  # @return [AvlNode] the new subtree root, left on the stack from the
  #  `rotate_right` invocation.
  def rotate_left_right
    left.rotate_left
    rotate_right
  end

  # As with `rotate_left_right`, a deletion may induce an otherwise balanced tree
  # to become unbalanced. An overweight right hand branch with a left child requires
  # rotating right first, then rotating left.
  #
  #       7                   7                   13
  #     /   \               /  \                 /   \
  #    5    19             5   13              7     19
  #        /  \   ===>         / \     ===>   / \    / \
  #       13  43            11  19           5  11  17 43
  #      /  \                  /  \
  #     11   17               17  43
  #
  # @return [AvlNode] the new subtree root, left on the stack from the `rotate_left` invocation.
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

  def balance_factor
    @balance_factor = right_height - left_height
  end

  def balanced?
    [-1, 0, 1].include? weight
  end

  # TODO: see if this can punt to the parent Node class.
  # Move the relevant tests to shared examples.
  #
  # @return [Integer] size of the tree rooted at the Node instance.
  def size
    size = 0
    post_order_traverse { size += 1 }
    size
  end

  def post_order_traverse(&)
    left&.post_order_traverse(&)
    right&.post_order_traverse(&)
    yield
  end
end
