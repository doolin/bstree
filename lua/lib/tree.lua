-- Tree is a container for a binary search tree.
-- Its primary function is to manage the root node.

local print = print
local lyaml = require "lyaml"

local Tree = {}

-- Don't remember why this function was implemented
function Tree:empty()
  return {
    key = nil,
    left = nil,
    right = nil
  }
end

function Tree:new(node)
  local tree = {
    root = node,
  }
  setmetatable(tree, self)
  self.__index = self
  return tree
end

function Tree:insert(node)
  self.root:insert(node)
end

function Tree:transplant(u, v)
  if u == self.root then
    self.root = v
  elseif u.parent.left == u then
    u.parent.left = v
  else
    u.parent.right = v
  end

  if v ~= nil then
    v.parent = u.parent
  end
end

function Tree:delete_node(key)
  z = self:search(key)

  if (z.left == nil) then
    self:transplant(z, z.right)
  elseif (z.right == nil) then
    self:transplant(z, z.left)
  else
    y = z.right:minimum()
    if y.parent ~= z then
      self:transplant(y, y.right)
      y.right = z.right
      y.right.parent = y
    end

    self:transplant(z, y)
    y.left = z.left
    y.left.parent = y
  end

  z:unlink()
  return z
end

function Tree:search(key)
  if self.root == nil then return nil end
  return self.root:search(key)
end

function Tree:is_present(key)
  if self.root == nil then return false end
  return self.root:is_present(key)
end

function Tree:collect(collector)
  if self.root == nil then return end
  self.root:collect(collector)
end

function Tree:list_keys()
  if self:is_empty() then return {} end
  return self.root:list_keys()
end

function Tree:successor(node)
  if self.root == nil then return end
  return self.root:successor(node)
end

function Tree:predecessor(node)
  if self.root == nil then return end
  return self.root:predecessor(node)
end

function Tree:is_empty()
  if self.root == nil then return true else return false end
end

function Tree:is_bst()
  if self.root == nil then return true end
  return self.root:is_bst()
end

function Tree:height()
  return self.root:height()
end

function Tree:size()
  if self.root == nil then return 0 end
  return self.root:size()
end

function Tree:maximum()
  if self.root == nil then return nil end
  return self.root:maximum()
end

function Tree:minimum()
  if self.root == nil then return nil end
  return self.root:minimum()
end

function build_from_yaml(filename)
  local f = io.open(filename, "r")
  local lines = f:read("*all")
  f:close()
  local t = lyaml.load(lines)

  return Tree:new(build_from_table(t))
end

return Tree
