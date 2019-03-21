defmodule Calculate do

	def parse(
	<<
		argOne::bitstring-size(16),
		_::bitstring-8,
		operation::bitstring-8,
		_::bitstring-8,
		argTwo::bitstring-size(16)
	>>
	) do
		"#{argOne} #{operation} #{argTwo}"
	end

	# :string.to_integer
	# List.to_integer - Single Quoted String is a Char List
	# String.to_integer - Double Quoted String is a String
	def char_list_to_integer(char_list) do
		reverse(char_list)
		|> Enum.map fn x -> x - 48 end
		|> sum_the_list
	end

	def reverse(list) do
		reverse(list, [])
	end

	defp reverse([head|tail], reversed_list) do
		reverse(tail, [head] ++ reversed_list)
	end

	defp reverse([], reversed_list) do
		reversed_list
	end

	def sum_the_list(char_list) do
		
	end
	
end

# Write a function that takes a single-quoted string of the form
# number [+-*/] number and returns the result of the calculation. 
# The individual numbers do not have leading plus or minus signs.

IO.puts Calculate.parse("12 + 50") # 62

IO.puts Calculate.reverse('12345')

