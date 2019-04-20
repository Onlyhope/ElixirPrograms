defmodule SequenceDaveTest do
  use ExUnit.Case
  doctest SequenceDave

  test "greets the world" do
    assert SequenceDave.hello() == :world
  end
end
