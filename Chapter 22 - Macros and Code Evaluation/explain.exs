defmodule Macro do
	
	defmacro explain(statement) do
		do_clause = Keyword.get(statement, :do)

		explain_expr(do_clause)
	end

	def explain_expr({operation, _, [arg1, arg2]}) when is_tuple(arg1) and is_tuple(arg2) do

		{evaluated_expr_1, _} = Code.eval_quoted(arg1)
		{evaluated_expr_2, _} = Code.eval_quoted(arg2)

		case operation do
			:+ -> "#{explain_expr(arg1)}, then #{explain_expr(arg2)}, then add #{evaluated_expr_1} and #{evaluated_expr_2}"
			:- -> "#{explain_expr(arg1)}, then #{explain_expr(arg2)}, then subtract #{evaluated_expr_1} and #{evaluated_expr_2}"
			:* -> "#{explain_expr(arg1)}, then #{explain_expr(arg2)}, then multiply #{evaluated_expr_1} and #{evaluated_expr_2}"
			:/ -> "#{explain_expr(arg1)}, then #{explain_expr(arg2)}, then divide #{evaluated_expr_1} and #{evaluated_expr_2}"
		end
	end

	def explain_expr({operation, _, [arg1, arg2]}) when is_tuple(arg1) do
		case operation do
			:+ -> "#{explain_expr(arg1)}, then add #{arg2}"
			:- -> "#{explain_expr(arg1)}, then subtract #{arg2}"
			:* -> "#{explain_expr(arg1)}, then multiply #{arg2}"
			:/ -> "#{explain_expr(arg1)}, then divide #{arg2}"		
		end
	end

	def explain_expr({operation, _, [arg1, arg2]}) when is_tuple(arg2) do
		case operation do
			:+ -> "#{explain_expr(arg2)}, then add #{arg1}"
			:- -> "#{explain_expr(arg2)}, then subtract #{arg1}"
			:* -> "#{explain_expr(arg2)}, then multiply #{arg1}"
			:/ -> "#{explain_expr(arg2)}, then divide #{arg1}"		
		end
	end

	def explain_expr({operation, _, [arg1, arg2]}) do
		case operation do
			:+ -> "add #{arg1} and #{arg2}"
			:- -> "subtract #{arg1} and #{arg2}"
			:* -> "multiply #{arg1} and #{arg2}"
			:/ -> "divide #{arg1} and #{arg2}"
		end
	end

end

defmodule Test do

	require Macro

	IO.inspect Macro.explain(do: 1 * 1 + 3 * 2 + 3 * 4)
	IO.inspect Macro.explain(do: 1 * (1 + 3) * 2 + 3 * 4)
	IO.inspect Macro.explain(do: 2 + 1 * 2 * 3)
	IO.inspect Macro.explain(do: 3 * 5 * 6 + 2 + 3 * 4 * 5)

end