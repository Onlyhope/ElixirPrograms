# Exercise ListAndRecursion - 5

defmodule MyEnum do
	# MyEnum.all?
	def all(list, func), do: all(list, func, true)
	def all([], _, ans), do: ans
	def all(_, _, false), do: false
	def all([head|tail], func, true) do
		all(tail, func, func.(head))
	end

	# MyEnum.each
	def each([], func), do: "ok"
	def each([head|tail], func) do
		func.(head)
		each(tail, func)
	end

	# MyEnum.filter
	def filter(list, func), do: filter(list, func, [])
	def filter([], func, answer), do: answer
	def filter([head|tail], func, answer) do
		if func.(head) do
			filter(tail, func, answer ++ [head])
		else
			filter(tail, func, answer)
		end
	end

	# MyEnum.split
	def split(list, count), do: split(list, count, {[], []})
	def split(list, -1, {first, second}), do: {first, second}
	def split([head|tail], count, {first, second}) when count > 1 do
		split(tail, count-1, {first ++ [head], second})
	end
	def split([head|tail], 1, {first, second}) do
		{ first ++ [head], tail}
	end
	def split(list, count, {first, second}) when count < -1 do
		IO.puts "Implement this later..."
	end

end

list = [1,2,3,4,5,1]
letters = [97, 98, 100, 105, 107, 115]

IO.puts letters
IO.puts MyEnum.all(list, fn(n) -> n > 1 end)
MyEnum.each(list, fn(n) -> IO.puts(n) end)
IO.puts MyEnum.filter(list, fn(n) -> n > 2 end)
IO.inspect MyEnum.split(list, 3)
