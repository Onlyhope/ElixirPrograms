# Exercise: MacrosAndCodeEvaluation-2

defmodule Times do
	
	defmacro times_n(x) do

		func_name = String.to_atom("times_#{x}")

		quote do
			def unquote(func_name)(y) do
				unquote(x) * y
			end
		end
	end

end

defmodule Test do 

	require Times

	Times.times_n(3)
	Times.times_n(4)

end

IO.puts Test.times_3(10)
IO.puts Test.times_4(5)
