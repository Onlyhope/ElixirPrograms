# Exercise ListAndRecursion - 5

defmodule MyEnum do
	def all(list, func), do: all(list, func, true)
	def all([], _, ans), do: ans
	def all(_, _, false), do: false
	def all([head|tail], func, true) do
		all(tail, func, func.(head))
	end
end

list = [1,2,3,4,5,1]

IO.puts MyEnum.all(list, fn(n) -> n > 1 end)