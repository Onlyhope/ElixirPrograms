# Exercise: ModulesAndFunctions-4
defmodule Sum do
	def add(0), do: 0
	def add(n), do: n + add(n-1)
end

# Exercise: ModulesAndFunctions-5

defmodule Gcd do
	def is(x, 0), do: x
	def is(x, y), do: is(y, rem(x,y))
end