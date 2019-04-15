defmodule FibSolver do
	
	@doc """
		Tells the scheduler that it is ready.
		Then it waits for a message from the scheduler.
		If it is :fib, then it runs fib(n) and returns it back to the client
		If it is :shutdown, then it exits
	"""
	def fib(scheduler) do
		# Tells the scheduler it's ready
		send(scheduler, {:ready, self()})
	
		receive do
			{:fib, n, client} ->
				# Send client the answer from fib_calc(n)
				send(client, {:answer, n, fib_calc(n), self()})
				# Recursively call fib(scheduler) to restart it
				fib(scheduler)
			{:shutdown} ->
				# If shutdown is received instead, exit.
				exit(:normal)
		end

	end

	# Deliberate inefficient solution
	defp fib_calc(0), do: 0
	defp fib_calc(1), do: 1
	defp fib_calc(n), do: fib_calc(n - 1) + fib_calc(n - 2)

end