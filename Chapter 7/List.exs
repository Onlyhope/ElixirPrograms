defmodule MyList do
  def len([]), do: 0
  def len([_|tail]), do: 1 + len(tail)
  def square([]), do: []
  def square([head|tail]), do: [head*head|square(tail)]
  def map([], _), do: []
  def map([head|tail], func), do: [ func.(head) | map(tail, func)]
  def mapsum([], _), do: 0
  def mapsum([head|tail], func), do: func.(head) + mapsum(tail, func)
  def my_max([head|tail]), do: my_max(tail, head)
  def my_max([head|tail], running_max) when running_max >= head do 
  	my_max(tail, running_max)
  end
  def my_max([head|tail], running_max) when head > running_max do
  	my_max(tail, head)
  end
  def my_max([], running_max), do: running_max
end

# Exercise: ListsAndRecursion - 1
IO.puts MyList.mapsum [1,2,3], &(&1 * &1)
# Exercise: ListsAndRecursion - 2
IO.puts MyList.my_max([42,18,93,53,42,59])
#