defmodule StackTest do
  use ExUnit.Case
  doctest Stack

  test "greets the world" do
  	IO.puts "Hello World"
    assert Stack.hello() == :world
  end
end
