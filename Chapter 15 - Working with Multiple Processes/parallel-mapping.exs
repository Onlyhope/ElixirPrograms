defmodule Parallel do

	def pmap(collection, fun) do
		
		me = self()

		collection
		|> Enum.map(fn (elem) -> 
			# Spawning a linked child process
			spawn_link fn -> (
				duration = (1000 - (elem * 10))
				:timer.sleep(duration)
				send me, { self(), fun.(elem) }) end
				# This is a child process that sends a message back to the parent
				# With the result of the applied function to the element
				# self() -> is the child's pid
				# me -> parent's pid
				# fun -> the function to apply
				# elem -> the element to be applied on		
		end)
		|> Enum.map(fn (pid) -> 
			# receive do {^pid, result} -> result end
			receive do {^pid, result} -> result end
		end)
	end

	# Creates a linked child process for each element in the collection.
	# Each child process will send the result of the applied function
	# back to its parent, along with its own PID. The parent, as of
	# right now, is a collection of PIDs (children). It takes all its
	# children PIDs and create a receiver which matches the incoming
	# PIDs to the correct position on the list. Without the ^pid, it will
	# be in the order of whoever comes first. Also, it is important to note
	# without the ^pid it is an entirely different variable. While, ^pid is a reference
	# to the variable given in the parameter and will retain the original
	# value. So the incoming PIDs must match with the original value.
end

# Exercise: WorkingWithMultipleProcesses-6
# In the pmap code, I assigned the value of self to the variable me
# at the top of the method and then used me as the target of the message
# returned by the spawned processes. Why use a separate variable here?

# Within the child process self() will return its own PID.
# There will be no knowledge of the parent's PID unless it's
# passed is a parameter... Or in this case it is accessible 
# in a larger scope.

# Exercise: WorkingWithMultipleProcesses-7
# Change the ^pid in pmap to _pid. This means the receive block
# will take responses in the order the processes send them. Now
# run the code again. Do you see any difference in the output?
# If you're like me, you don't, but the program clearly contains a bug.
# Are you scared by this? Can you find a way to reveal the problem
# (perhaps by passing in a different function, by sleeping, or by increasing
# the number of processes)? Change it back to ^pid and make sure
# the order is now correct.

# Increase the processess being run. Also add a timer to delay 
# the values that are first. So, in theory they would be listed in reverse.












