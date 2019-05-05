defmodule My do
	
	defmacro macro(param) do
		IO.inspect(param)
	end

	def aFunc(x) do
		IO.puts "#{inspect x}"
	end

end

defmodule Test do
	
	require My

	# These values represent themselves
	My.macro :atom
	My.macro 1
	My.macro 1.0
	My.macro [1,2,3]
	My.macro "binaries"
	My.macro {1,2}
	My.macro do: 1

	# And these are represented by 3-element tuples

	My.macro {1,2,3,4,5}
	# => {:"{}", [line: 24], [1,2,3,4,5]}

	My.macro do: (a = 1; a+a)
	# [
	#   do: {:__block__, [line: 27],
	#    [
	#      {:=, [line: 27], [{:a, [line: 27], nil}, 1]},
	#      {:+, [line: 27], [{:a, [line: 27], nil}, {:a, [line: 27], nil}]}
	#    ]}
	# ]

	My.macro do
		1 + 2
	else
		3 + 4
	end
	# [do: {:+, [line: 37], [1, 2]}, else: {:+, [line: 39], [3, 4]}]

	My.macro(My.aFunc(2))
	# {{:., [line: 47], [{:__aliases__, [line: 47], [:My]}, :aFunc]}, [line: 47], [2]}


end