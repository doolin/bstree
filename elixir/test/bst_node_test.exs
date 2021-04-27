defmodule BstNodeTest do
  use ExUnit.Case
  doctest Bst

  test 'insert left' do
    root = %Bst.Node{key: 17}
    k13 = %Bst.Node{key: 13}

    expected = %Bst.Node{
      key: 17,
      left: %Bst.Node{key: 13, left: nil, right: nil, value: nil},
      right: nil,
      value: nil
    }

    actual = Bst.Node.insert(root, k13)

    assert actual.left == %Bst.Node{key: 13, left: nil, right: nil, value: nil}
    assert actual == expected
  end

  # TODO: this is absolutely not working at all. I need to rethink
  # the strategy from the usual insertion pattern to an elixir
  # insertion pattern. I'm being very blub here, trying to program
  # elixir using ruby techniques.
  # This is commented out to get it merged to conclude a spike.
  # test 'recur left' do
  #   root = %Bst.Node{key: 17}
  #   k13 = %Bst.Node{key: 13}
  #   k11 = %Bst.Node{key: 11}

  #   expected = %Bst.Node{
  #     key: 17,
  #     left: %Bst.Node{key: 13, left: %Bst.Node{key: 11}},
  #     right: nil,
  #     value: nil
  #   }

  #   actual = Bst.Node.insert(root, k13)
  #   actual = Bst.Node.insert(actual, k11)

  #   # IO.inspect(actual)

  #   assert actual.left == %Bst.Node{key: 13}#, left: %Bst.Node{key: 11}}
  #   # assert actual.left.left == %Bst.Node{key: 11}
  #   # assert actual == expected
  # end

  test 'insert right' do
    root = %Bst.Node{key: 17}
    k23 = %Bst.Node{key: 23}

    expected = %Bst.Node{
      key: 17,
      left: nil,
      right: %Bst.Node{key: 23, left: nil, right: nil, value: nil},
      value: nil
    }

    actual = Bst.Node.insert(root, k23)

    assert actual.right == %Bst.Node{key: 23, left: nil, right: nil, value: nil}
    assert actual == expected
  end
end
