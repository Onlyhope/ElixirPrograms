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

testList = [[1,10,[2]],[3],[[[4]]]]

IO.inspect MyList.flatten(testList)

list = [1,[2,3,[4,5],6],7,[8],[9,[10],11]]

# IO.inspect MyList.flatten(list)