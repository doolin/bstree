defmodule BstTest do
  use ExUnit.Case
  doctest Bst

  test 'testem' do
    assert Bst.Node.testem() == 'testem'
  end

  test 'read yaml fixture' do
    path = Path.join(File.cwd!(), "../fixtures/tree1.yml")
    expected = {:ok, %{"key" => 11, "left" => nil, "right" => nil, "uuid" => "uuid"}}
    actual = YamlElixir.read_from_file(path)
    # IO.inspect(actual, limit: :infinity)

    assert actual == expected
  end
end
