defmodule Bst.Node do
  @moduledoc "My server code."

  defstruct key: nil, value: nil, parent: nil, left: nil, right: nil

  def insert(root, new) do
    # IO.inspect(root)

    if root.key < new.key do
      if root.left == nil do
        %Bst.Node{key: root.key, right: new}
      else
        # IO.inspect(root)
        Bst.Node.insert(root.left, new)
      end
    else
      if root.right == nil do
        %Bst.Node{key: root.key, left: new}
      else
        # IO.inspect(root)
        Bst.Node.insert(root.root, new)
      end
    end
  end
end
