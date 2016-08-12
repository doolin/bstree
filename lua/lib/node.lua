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
      self.left = n
    else
      self.left:insert(n)
    end
  else
    if self.right == nil then
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

function Node:collect(collector)
  if self.left then self.left:collect(collector) end
  collector[#collector + 1] = self.key
  if self.right then self.right:collect(collector) end
end

return Node