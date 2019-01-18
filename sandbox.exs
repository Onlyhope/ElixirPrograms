defmodule MyList do
  def len([]), do: 0
  def len([head|tail]), do: 1 + len(tail)
  def square([]), do: []
  def square([head|tail]), do: [head*head|square(tail)]
  def map([], func), do: []
  def map([head|tail], func), do: [ func.(head) | map(tail, func)]
end
