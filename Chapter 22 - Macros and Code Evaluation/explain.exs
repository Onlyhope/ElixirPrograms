defmodule Macro do
	
	defmacro explain(arg) do
		IO.inspect(arg)
	end

end

defmodule Test do

	require Macro

	Macro.explain(do: 2 + 3 * 4)
	[
		do: {:+, 
				[line: 13],
				[2, {:*, [line: 13], [3, 4]}
				]
		}
	]
end