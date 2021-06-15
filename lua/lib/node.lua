local print = print

local Node = {}

function Node:new(key)
  local node = {
    key = key,
    left = nil,
    right = nil
  }
  setmetatable(node, self)
  self.__index = self
  return node
end

function Node:insert(n)
  if n.key < self.key then
    if self.left == nil then
      n.parent = self
      self.left = n
    else
      self.left:insert(n)
    end
  else
    if self.right == nil then
      n.parent = self
      self.right = n
    else
      self.right:insert(n)
    end
  end
end

function Node:search(key)
  if self.key == key then return self end

  if self.left and key < self.key then
    return self.left:search(key)
  else
    if self.right then
      return self.right:search(key)
    end
  end
  return nil
end

function Node:is_present(key)
  if self.key == key then return true end

  if self.left and key < self.key then
    return self.left:is_present(key)
  else
    if self.right then
      return self.right:is_present(key)
    end
  end
  return false
end

function Node:get_successor(node, parent, successor)
  if parent.left and parent.left == self then successor = parent end

  if self == node then
    if self.right then
      return self.right:minimum()
    else
      return successor
    end
  end

  if node.key < self.key then
    if self.left then
      return self.left:get_successor(node, self, successor)
    end
  else
    if self.right then
      return self.right:get_successor(node, self, successor)
    end
  end
end

function Node:successor(node)
  return self:get_successor(node, self, node)
end

function Node:get_predecessor(node, parent, predecessor)
  if parent.right == self then predecessor = parent end

  if node == self then
    if self.left then
      return self.left:maximum()
    else
      return predecessor
    end
  end

  if node.key < self.key then
    if self.left then
      return self.left:get_predecessor(node, self, predecessor)
    end
  else
    if self.right then
      return self.right:get_predecessor(node, self, predecessor)
    end
  end
end

function Node:predecessor(node)
  return self:get_predecessor(node, self, node)
end

function Node:list_keys()
  collector = {}
  self:collect(collector)
  return collector
end

function Node:collect(collector)
  if self.left then self.left:collect(collector) end
  collector[#collector + 1] = self.key
  if self.right then self.right:collect(collector) end
end

function Node:post_order_traverse(callback)
  if self.left then self.left:post_order_traverse(callback) end
  if self.right then self.right:post_order_traverse(callback) end
  callback()
end

function Node:in_order_traverse(callback)
  if self.left then self.left:in_order_traverse(callback) end
  callback(self)
  if self.right then self.right:in_order_traverse(callback) end
end

function Node:get_height(height, max)
  current = height + 1
  if self.left then max = self.left:get_height(current, max) end
  if self.right then max = self.right:get_height(current, max) end
  current = current - 1
  if current > max then max = current end
  return max
end

function Node:height()
  return self:get_height(0, 0)
end

function Node:is_bst()
  local result = true
  local minimum = -10000
  self:in_order_traverse(function(node)
    if minimum >= node.key then
      result = false
    end
    minimum = node.key
  end)
  return result
end

function Node:size()
  size = 0
  self:post_order_traverse(function () size = size + 1 end)
  return size
end

function Node:maximum()
  if (self.right == nil) then
    return self
  else
    return self.right:maximum()
  end
end

function Node:minimum()
  if (self.left == nil) then
    return self
  else
    return self.left:minimum()
  end
end

function Node:unlink()
  self.left = nil
  self.right = nil
  self.parent = nil
end

function Node:is_unlinked()
  return self.left == nil and self.right == nil and self.parent == nil
end

function Node:tprint (tbl, indent)
  if not indent then indent = 0 end

  for k, v in pairs(tbl) do
    formatting = string.rep("  ", indent) .. k .. ": "

    if type(v) == "table" and k ~= "parent" then
      print(formatting)
      tbl:tprint(v, indent+1)
    elseif type(v) == 'boolean' then
      print(formatting .. tostring(v))
    else
      print(formatting .. tostring(v))
    end
  end
end

return Node
