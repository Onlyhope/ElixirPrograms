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

# quote do => Turns code into code fragment
# quote do: 1 + 1, will result in a tuple
# {:+, [_line_number], [1,1]}

# when you see quote: it says "interpret the content of the block
# that follows as code, and return the internal representation"
# - Dave Thomas

# unquote can only be use within quote blocks
# unquote can be called inject_code_fragment
# so if you have code_fragment to be used within
# a quote block you must use unquote to incorporate
# it into the quote block. Otherwise Elixir will
# read it is normal code.

# Example:

# quote do
# 	if !condition do
# 		do_clause
# 	end
# end

# Will be read as:

# quote do
# 	if !condition() do
# 		do_clause()
# 	end
# end

# While

# quote do
# 	if !unquote(condition) do
# 		unquote(do_clause)
# 	end
# end

# Will be read as:

# quote do
# 	if !CONDITION_FRAGMENT do
# 		DO_CLAUSE_FRAGMENT
# 	end
# end
