class Node
  attr_reader :left, :right
  attr_accessor :value

  def initialize value = nil
    @value = value
  end

  def <=> other
    return -1 if other.value < self.value
    other.value == value ? 0 : 1
  end

  def < other
    return true if @value < other.value
    false
  end

  def add node
    node < self ? addleft(node) : addright(node)
  end

  def find key
    return self if key == self.value
    key < self.value ? findleft(key) : findright(key)
  end

  def findleft key
    return if @left.nil?
    key == @left.value ? @left : @left.find(key)
  end

  def findright key
    return if @right.nil?
    key == @right.value ? @right : @right.find(key)
  end

  def addleft node
    @left.nil? ? @left = node : @left.add(node)
  end

  def addright node
    @right.nil? ? @right = node : @right.add(node)
  end
end