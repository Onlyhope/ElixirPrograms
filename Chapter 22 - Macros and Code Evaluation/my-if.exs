defmodule My do
	defmacro if(condition, clauses) do
		# IO.puts "Condition: #{inspect(condition)}"
		# IO.puts "Clauses: #{inspect(clauses)}"

		do_clause = Keyword.get(clauses, :do, nil)
		else_clause = Keyword.get(clauses, :else, nil)

		# IO.puts "do_clause: #{inspect do_clause}"
		# IO.puts "else_clause: #{inspect else_clause}"
		quote do
			case unquote(condition) do
				val when val in [false, nil]->
					IO.puts "Val: #{val}"
					unquote else_clause
				_otherwise -> 
					unquote do_clause
			end
		end
	end
end

defmodule Test do
	
	require My

	My.if 1 == 2 do
		IO.puts "1 == 2"
	else
		IO.puts "1 != 2"
	end

end