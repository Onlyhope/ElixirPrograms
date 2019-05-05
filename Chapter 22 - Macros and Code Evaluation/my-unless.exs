# Exercise: MacrosAndCodeEvaluation-1

defmodule My do
	
	defmacro unless(condition, clauses) do
		do_clause = Keyword.get(clauses, :do)

		quote do
			if !unquote(condition) do
				unquote(do_clause)
			end
		end

	end

end

defmodule Test do
	
	require My

	unless 2 == 2 do
		IO.puts "First: not true"
	end

	My.unless 2 == 2 do
		IO.puts "Second: not true"
	end

end


