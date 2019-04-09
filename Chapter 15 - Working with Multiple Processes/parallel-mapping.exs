defmodule Parallel do

	def pmap(collection, fun) do
		
		me = self()

		collection
		|> Enum.map(fn (elem) -> 
			# Spawning a linked child process
			spawn_link fn -> (send me, { self(), fun.(elem) }) end
				# This is a child process that sends a message back to the parent
				# With the result of the applied function to the element
				# self() -> is the child's pid
				# me -> parent's pid
				# fun -> the function to apply
				# elem -> the element to be applied on		
		end)
		|> Enum.map(fn (pid) -> 
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