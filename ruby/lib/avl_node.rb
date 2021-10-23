# frozen_string_literal: true

require 'node'

class AvlNode < Node
  attr_writer :balance_factor

  def initialize(key)
    super
    @balance_factor = 0
  end

  def insert(node, balance: true)
    super
    balance_node if balance
  end

  # rubocop:disable  Metrics/MethodLength
  def balance_node
    @balance_factor = weight

    if @balance_factor < -1
      if left.balance_factor == 1
        d_rot_right
      else
        right_rot
      end
    elsif @balance_factor > 1
      if right.balance_factor == -1
        d_rot_left
      else
        left_rot
      end
    end
  end
  # rubocop:enable  Metrics/MethodLength

  def d_rot_right; end

  def right_rot; end

  def d_rot_left; end

  def left_rot; end

  # I believe this and the rotate_left methods are probably correct.
  # The challenge is that after the rotation, there may be a new subtree
  # root, which may be the root of the entire tree as well. This case is
  # not covered by any of the literature, and frankly is there more
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

  #    13                   19
  #   /   \      ===>      /  \
  #  11   19             13    23
  #       /  \          /  \     \
  #     17   23        11   17    43
  #            .
  #            n43
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
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

  def balance_factor
    @balance_factor = right_height - left_height
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
