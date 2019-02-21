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
	def each([], _), do: "ok"
	def each([head|tail], func) do
		func.(head)
		each(tail, func)
	end

	# MyEnum.filter
	def filter(list, func), do: filter(list, func, [])
	def filter([], _, answer), do: answer
	def filter([head|tail], func, answer) do
		if func.(head) do
			filter(tail, func, answer ++ [head])
		else
			filter(tail, func, answer)
		end
	end

	# MyEnum.split
	def split(list, count), do: split(list, count, {[], []})
	def split(_, -1, {first, second}), do: {first, second}
	def split([head|tail], count, {first, second}) when count > 1 do
		split(tail, count-1, {first ++ [head], second})
	end
	def split([head|tail], 1, {first, _}) do
		{ first ++ [head], tail}
	end
	def split(list, count, {first, second}) when count < -1 do
		split(list, length(list) + count, {first, second})
	end

	# MyEnum.take
	def take(list, amount) when amount > 0 do
		take(list, amount, [])
	end
	def take(list, amount) when amount < 0 do
		remove(list, length(list) + amount)
	end
	def take(_, 0, answer), do: answer
	def take([head|tail], amount, answer) when amount > 0 do
		take(tail, amount-1, answer ++ [head])
	end

	def remove(list, 0), do: list
	def remove([_|tail], amount) when amount > 0 do
		remove(tail, amount-1)
	end


end

list = [1,2,3,4,5,1]
letters = [97, 98, 100, 105, 107, 115]

IO.puts letters
IO.puts MyEnum.all(list, fn(n) -> n > 1 end)
MyEnum.each(list, fn(n) -> IO.puts(n) end)
IO.puts MyEnum.filter(list, fn(n) -> n > 2 end)
IO.inspect MyEnum.split(list, 3)
IO.inspect MyEnum.split(list, -2)
IO.inspect MyEnum.take(list, 3)
IO.inspect MyEnum.take(list, -1)
