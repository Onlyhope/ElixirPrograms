defmodule Test do

	defstruct(content: [])

	def main do
		list = [1,2,3]
		Enum.reduce(list, fn(x, acc) -> x + acc end)
	end

end

defimpl Enumerable, for: Test do
	
	# Exercise: Protocols-3

	# Collections that implement the Enumerable protocol
	# define count, member?, reduce, and slice fuunctions.
	# The Enuum module uses these to implement methods
	# such as each, filter, and map

	# Implement youur own versions of each, filter,
	# and map in terms of reduce.

	def reduce(list, state, fun) when is_list(list) do
		IO.inspect list
		IO.inspect state
		_reduce(list, state, fun)
	end

	def _reduce(_list, {:halt, acc}, _fun) do
		{:halted, acc}
	end

	def _reduce(list, {:suspended, acc}, fun) do
		{:suspended, acc, &_reduce(list, &1, fun)}
	end

	def _reduce(_list, {:cont, acc}, _fun) do
		{:done, acc}
	end

	def _reduce([head|tail], {:cont, acc}, fun) do
		_reduce(tail, fun.(head, acc), fun)
	end

	def count(list) do
		count = Enum.reduce(list, 0, fn(_, count) -> count + 1 end)
		{:ok, count}
	end

	def member?(_, _) do
		{:error, __MODULE__}
	end		

	def slice(_) do
		{:error, __MODULE__}
	end

end

