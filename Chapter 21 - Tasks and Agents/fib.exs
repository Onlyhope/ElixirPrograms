defmodule Fib do
	
	def of(0), do: 0
	def of(1), do: 1
	def of(n), do: Fib.of(n-1) + Fib.of(n-2) 

end

IO.puts "Start the task"