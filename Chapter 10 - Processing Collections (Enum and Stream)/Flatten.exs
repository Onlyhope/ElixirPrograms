defmodule MyList do

	def flatten(list), do: flatten(list, [])
	def flatten([], answer), do: answer

	def flatten([head|tail], answer) when is_list(head) do
		flatten(tail, answer ++ flatten(head))
	end

	def flatten([head|tail], answer) do
		flatten(tail, answer ++ [head])
	end

end

testList1 = [[1,10,[2]],[3],[[[4]]]]
IO.puts "Input:"
IO.inspect testList1

IO.puts "Output:"
IO.inspect MyList.flatten(testList1)

# To solve for the unrolling case=
testList2 = [[[3]]]
IO.puts "Input:"
IO.inspect testList2

IO.puts "Output:"
IO.inspect MyList.flatten(testList2)
