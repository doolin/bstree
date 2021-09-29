defmodule BstTest do
  use ExUnit.Case
  doctest Bst

  # TODO: convert the strings to atoms:
  # https://stackoverflow.com/questions/41980358/convert-maps-to-struct
  # then create a struct
  #
  # also, configure credo: https://hexdocs.pm/credo/config_file.html
  test 'read yaml fixture' do
    path = Path.join(File.cwd!(), "../fixtures/tree1.yml")
    expected = {:ok, %{"key" => 11, "left" => nil, "right" => nil, "uuid" => "uuid11"}}
    actual = YamlElixir.read_from_file(path)
    # IO.inspect(actual, limit: :infinity)
    # IO.inspect(actual)
    assert actual == expected
  end
end
