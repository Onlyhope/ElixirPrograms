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
  def caesar([], _), do: []
  def caesar([head|tail], n) when (head + n) > 122 do
  	[ rem(head + n, 122) | caesar(tail, n)]
  end
  def caesar([head|tail], n), do: [ head + n | caesar(tail, n)]
  def span(from, to), do: span(from, to, [])
  def span(from, to, ans) when from == to do
    ans ++ [from]
  end
  def span(from, to, ans) do
    span(from+1, to, ans ++ [from])
  end
  def between(from, to, list) do
    between(from, to, list, [])
  end
  def between(0, 0, _, ans), do: ans
  def between(from, to, [head|tail], ans) when from > 0 do
    # Continue when from > 0 and to > 0
    between(from-1, to-1, tail, ans)
  end
  def between(from, to, [head|tail], ans) when from == 0 do
    # Append when from == 0 and to > 0
    between(from, to-1, tail, ans ++ [head])
  end
end

# Exercise: ListsAndRecursion - 1
IO.puts MyList.mapsum [1,2,3], &(&1 * &1)

# Exercise: ListsAndRecursion - 2
IO.puts MyList.my_max([42,18,93,53,42,59])

# Exercise: ListsAndRecursion - 3
IO.puts MyList.caesar('abcdef', 1)
IO.puts MyList.caesar('abcdef', 122)
IO.puts MyList.caesar('abcdef', 123)

# Exercise: ListsAndRecursion - 4
IO.puts MyList.span(97, 122)

# Exercise: ListsAndRecursion - 5 (Mis-understood Question)
testList = [97,98,99,100,101,102,103,104]
IO.puts MyList.between(2, 5, testList)

