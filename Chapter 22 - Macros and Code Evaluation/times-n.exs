# Exercise: MacrosAndCodeEvaluation-2

defmodule Times do
	
	defmacro times_n(x) do

		quote do
			def times(n) do
				n
			end
		end
		
	end

end

defmodule Test do 

	require Times

	Times.times_n(3)
	# Times.times_n(4)

end

IO.puts Test.times(10)
# IO.puts Test.times_4(5)
