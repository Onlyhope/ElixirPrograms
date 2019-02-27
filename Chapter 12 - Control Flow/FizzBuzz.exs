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

# ControlFlow-1: Rewrite the FizzBuzz example using case
IO.inspect FizzBuzz.upto(16)

# System.halt(0)