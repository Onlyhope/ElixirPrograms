defprotocol Enumerable do
	def count(enumerable)
	def reduce(enumerable, acc, fun)
	def member?(enumerable, value)
	def slice(enumerable)
end

defmodule ListWrapper do

	defstruct(content: [])

	def wrap(list), do:
		%ListWrapper{content: list}

end

defimpl Enumerable, for: ListWrapper do
	
	# Exercise: Protocols-3

	# enumerables that implement the Enumerable protocol
	# define count, member?, reduce, and slice fuunctions.
	# The Enum module uses these to implement methods
	# such as each, filter, and map

	# Implement youur own versions of each, filter,
	# and map in terms of reduce.

	def reduce(%ListWrapper{content: list}, state, fun) when is_list(list) do
		IO.puts "Initial Reduce: #{inspect list} #{inspect state}"
		_reduce(list, state, fun)
	end

	def _reduce(_list, {:halt, acc}, _fun) do
		IO.puts "Halting..."
		{:halted, acc}
	end

	def _reduce(list, {:suspended, acc}, fun) do
		IO.puts "Suspending..."
		{:suspended, acc, &_reduce(list, &1, fun)}
	end

	def _reduce([], {:cont, acc}, _fun) do
		IO.puts "Done..."
		{:done, acc}
	end

	def _reduce(_list = [head|tail], _state = {:cont, acc}, fun) do
		result = fun.(head, acc) |> elem(1)
		IO.inspect "Reducer result: #{inspect result}"
		_reduce(tail, result, fun)
	end

	def count(enumerable = %ListWrapper{content: list}) do

		reducer =
		fn (_, count) -> {:cont, count + 1} end

		{:ok, Enum.reduce(enumerable, 0, reducer)}
	end

	def member?(enumerable = %ListWrapper{content: list}, e) do

		reducer = 
		fn
			v, _ when v === e -> {:halt, true}
			_, _ -> {:cont, false}
		end

		{:ok, Enum.reduce(enumerable, false, reducer)}
	end

	def slice(enumerable = %ListWrapper{content: list}) do
		IO.puts "slice not implemented yet: #{inspect enumerable}"

		count = Enum.count(enumerable)
		
		slice_fun =
		fn 
			beg_ind, end_ind -> IO.puts "beg_ind: #{inspect beg_ind} end_ind: #{inspect end_ind}" 
		end

		{:ok, count, slice_fun}
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
		IO.inspect Enum.member?(list, 3)
		IO.inspect Enum.member?(list, 5)
		IO.inspect Enum.slice(list, 1, 3)	
		IO.inspect Enum.slice(list, 1..3)

	end
end

MyTest.run


