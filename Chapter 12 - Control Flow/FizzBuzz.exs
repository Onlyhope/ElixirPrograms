defmodule FizzBuzz do

	def upto(n) 
	when n > 0 do
		1..n |> Enum.map(&fizzbuzz/1)	
	end

	defp fizzbuzz(n) do
		case {rem(n, 3), rem(n, 5)} do
			{0, 0} -> "FizzBuzz"
			{0, _} -> "Fizz"
			{_, 0} -> "Buzz"
			{_, _} -> n
		end
	end

	defp better_fizzbuzz(n), do: _fizzword(n, rem(n,3), rem(n,5))

	defp _fizzword(_n, 0, 0), do: "FizzBuzz"
	defp _fizzword(_n, 0, _), do: "Fizz"
	defp _fizzword(_n, _, 0), do: "Buzz"
	defp _fizzword(n, _, _), do: n
	
end

defmodule ExceptionWrapper do
	def ok!({status, result}) do
		case {status, result} do
			{:ok, _data} -> _data
			{:error, _error} -> "Failed: #{_error}"
		end
	end
end

# ControlFlow-1: Rewrite the FizzBuzz example using case
IO.inspect FizzBuzz.upto(16)

# ControlFlow-2: 

# I prefer the case implementation over the guard clause implementation.
# Reasoning is all the cases are grouped up well in one function over the other
# This is a matter of discrete states. Maybe in the case of continuous state
# the guard clause method with when will be more appropriate
# Condition is un-ideal because it's not necessarily a condition that must be met, 
# but the output of two differenct condition will give you a certain case / state.

# ControlFlow-3:

file = ExceptionWrapper.ok! File.open("somefile.txt")