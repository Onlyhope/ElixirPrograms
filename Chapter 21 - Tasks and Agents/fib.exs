defmodule Fib do
	
	def of(0), do: 0
	def of(1), do: 1
	def of(n), do: Fib.of(n-1) + Fib.of(n-2) 

end

IO.puts "Start the task"
# worker = Task.async(fn -> Fib.of(20) end)
worker = Task.async(Fib, :of, [20])
IO.puts "Do something else"

# ...

IO.puts "Wait for the task"
result = Task.await(worker)
IO.puts "The result is #{result}"

# Can also run them as children of a supervisors
children = [
	{Task, Fib.of(20)}
]

Supervisor.start_link(children, strategy: :one_for_one)

# Task is essentially a fuction that runs in the background and can be used as a state
