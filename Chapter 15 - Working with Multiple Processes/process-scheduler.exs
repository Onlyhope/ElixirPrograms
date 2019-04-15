# Exercise: WorkingWithMultipleProcesses-9
# Take this scheduler code and update it to let you run a function that finds the number
# of times the word "cat" appears in each file in a given directory. Run one server process
# per file. The function File.Is! returns the names of files in a directory, and File.read!
# reads the contents of a file as a binary. Can you write it as a more generalized scheduler?

defmodule Scheduler do

	# import FibSolver
	import ArbitraryFunction
	
	@doc """
		
	"""
	def run(num_processes, module, func, to_calculate) do
		
		(1..num_processes)
		# Spawn returns a PID of the spawned process - List of PIDs
		|> Enum.map(fn(_) -> spawn(module, func, [self()]) end)
		# Pass each PID to schedule processes
		|> schedule_processes(to_calculate, [])

	end

	@doc """
		processes => the process to be scheduled
		queue => the queue that holds all the processes
		results => the list of results
	"""
	defp schedule_processes(processes, queue, results) do
		
		receive do
			{:ready, pid} when queue != [] ->
				# Receive ready status and there is work on the queue
				[ next | tail ] = queue
				send pid, {:main, next, self()}
				schedule_processes(processes, tail, results)
			{:ready, pid} when queue == [] ->
				# Receive ready status but queue is empty, send shut-down
				send pid, {:shutdown}
				if length(processes) > 1 do
					# Deletes the processes on the list, with the pid
					schedule_processes(List.delete(processes, pid), queue, results)
				else
					# Sorts the results
					Enum.sort(results, fn {n1,_}, {n2,_} -> n1 <= n2 end)
				end
			{:answer, number, result, _pid} ->
				# Receives an answer and append the answer to results
				schedule_processes(processes, queue, [{number, result} | results])
		end

	end

end

# to_process = List.duplicate(37,20) # %%%%%%%%%%%%%%%%%%%%
to_process = Enum.to_list(1..10)

Enum.each 1..10, fn num_processes ->
	{time, result} = :timer.tc(
		Scheduler, :run,
		[num_processes, ArbitraryFunction, :main, to_process]
	)

	if num_processes == 1 do
		IO.puts inspect result
		IO.puts "\n #    time (s)"
	end
		:io.format "~2B    ~.2f~n", [num_processes, time/1000000.0]
	end











