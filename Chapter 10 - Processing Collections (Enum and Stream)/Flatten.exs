defmodule MyList do
	def flatten(list), do: flatten(list, [])
	def flatten([], answer), do: answer
	def flatten([head|tail], answer) when is_list(head) do
		IO.puts "#{head} is list"
		flatten(head, tail, answer)
	end
	def flatten([head|tail], answer) do
		flatten(tail, answer ++ [head])
	end
	def flatten([], left_over, answer) do
		flatten(left_over, answer)
	end
	def flatten([head|tail], left_over, answer) do
		flatten(tail, left_over, answer ++ [head])
	end

end

testList1 = [[1,10,[2]],[3],[[[4]]]]
IO.puts "Input:"
IO.inspect testList1

IO.puts "Output:"
IO.inspect MyList.flatten(testList1)

# Doesn't unroll the following case: [[[3]]]
testList2 = [[[3]]]
IO.puts "Input:"
IO.inspect testList2

IO.puts "Output:"
IO.inspect MyList.flatten(testList2)


# IO.inspect MyList.flatten(list)