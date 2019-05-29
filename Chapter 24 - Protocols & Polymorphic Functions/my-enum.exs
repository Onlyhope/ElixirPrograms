defprotocol Enumerable do
	def count(collection)
	def reduce(collection, acc, fun)
	def member?(collection, value)
	def slice(collection)
end

defmodule ListWrapper do

	defstruct(content: [])

	def wrap(list), do:
		%ListWrapper{content: list}

end

defimpl Enumerable, for: ListWrapper do
	
	# Exercise: Protocols-3

	# Collections that implement the Enumerable protocol
	# define count, member?, reduce, and slice fuunctions.
	# The Enum module uses these to implement methods
	# such as each, filter, and map

	# Implement youur own versions of each, filter,
	# and map in terms of reduce.

	def reduce(%ListWrapper{content: list}, state, fun) when is_list(list) do
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

	def _reduce([], {:cont, acc}, _fun) do
		{:done, acc}
	end

	def _reduce(_list = [head|tail], _state = {:cont, acc}, fun) do
		# IO.inspect _list
		# IO.inspect _state
		_reduce(tail, fun.(head, acc), fun)
	end

	def count(%ListWrapper{content: list}) do
		count = Enum.reduce(list, 0, fn(_, count) -> count + 1 end)
		{:ok, count}
	end

	def member?(collection = %ListWrapper{content: list}, _) do
		IO.puts "Not implemented yet: #{inspect collection}"
		{:error, __MODULE__}
	end		

	def slice(collection = %ListWrapper{content: list}) do
		IO.puts "Not implemented yet: #{inspect collection}"
		{:error, __MODULE__}
	end

end

defimpl Inspect, for: ListWrapper do
	
	# Exercise: Protocols-4

	# In many cases, inspect will return a valid Elixir literal
	# for the value being inspected. Update the inspect function
	# for structs so that it returns valid Elixir code to construct
	# a new struct equal to the value being inspected

	# Can re-implement with Inspect.Algebra for more accuracy

	def inspect(%ListWrapper{content: list}, opts) do
		"ListWrapper[ #{list} ]"
	end
end

defmodule MyTest do
	def run() do
		list = ListWrapper.wrap([1,2,3,4])

		IO.inspect list

		IO.inspect Enum.count(list)
		IO.inspect Enum.member?(list, 1)
		IO.inspect Enum.member?(list, 5)		
	end
end

MyTest.run


