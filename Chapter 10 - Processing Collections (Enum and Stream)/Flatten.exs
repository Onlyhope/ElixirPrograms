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

# The key insight is understanding that if 
# an element is a list, it is the same sub-problem
# as the larger one and you can call flatten on it again

# My initial results were 1-level of flatten.
# Then I realize if the element is a list, it's the
# same sub-problem. 
# sub_problem_nswer ++ the rest of the list.


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
