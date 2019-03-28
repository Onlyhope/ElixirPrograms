defmodule Calculate do

	def calculate(arguments) do
		parse(arguments, [], [])
		|> compute_case
	end

	defp parse([32|tail], arg, arg_list) when arg != [] do
		parse(tail, [], arg_list ++ [arg])
	end

	defp parse([32|tail], arg, arg_list) when arg == [] do
		parse(tail, [], arg_list)
	end

	defp parse([head|tail], arg, arg_list) do
		parse(tail, arg ++ [head], arg_list)
	end

	defp parse([], arg, arg_list) when arg != [] do
		arg_list ++ [arg]
	end

	defp compute_case([arg1, op, arg2]) do
		case op do
			'+' -> List.to_integer(arg1) + List.to_integer(arg2)
			'-' -> List.to_integer(arg1) - List.to_integer(arg2)
			'*' -> List.to_integer(arg1) * List.to_integer(arg2)
			'/' -> List.to_integer(arg1) / List.to_integer(arg2)
		end
	end

	defp compute([arg1, op, arg2]) when op == '+' do
		List.to_integer(arg1) + List.to_integer(arg2)
	end

	defp compute([arg1, op, arg2]) when op == '-' do
		List.to_integer(arg1) - List.to_integer(arg2)
	end

	defp compute([arg1, op, arg2]) when op == '*' do
		List.to_integer(arg1) * List.to_integer(arg2)
	end

	defp compute([arg1, op, arg2]) when op == '/' do
		List.to_integer(arg1) / List.to_integer(arg2)
	end

	# :string.to_integer
	# List.to_integer - Single Quoted String is a Char List
	# String.to_integer - Double Quoted String is a String
	def char_list_to_integer(char_list) do
		reverse(char_list)
		|> Enum.map(fn x -> x - 48 end)
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
		sum_the_list(char_list, 0, 1)
	end

	def sum_the_list([head|tail], sum, pos) do
		sum_the_list(tail, sum + (pos * head), pos * 10)
	end

	def sum_the_list([], sum, _) do
		sum
	end
	
end

# Write a function that takes a single-quoted string of the form
# number [+-*/] number and returns the result of the calculation. 
# The individual numbers do not have leading plus or minus signs.

IO.puts "3 + 5"
IO.puts "#{Calculate.calculate('3 + 5')}"

IO.puts "15 - 5"
IO.puts "#{Calculate.calculate('15 - 5')}"

IO.puts "3 * 5"
IO.puts "#{Calculate.calculate('3 * 5')}"

IO.puts "15 / 5"
IO.puts "#{Calculate.calculate('15 / 5')}"

