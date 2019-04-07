defmodule MonitorAndLink do

	# send a message to the parent
	# Then exit

	import :timer, only: [sleep: 1]

	def send_and_exit(parent) do
		
		# raise "Exception raised by #{inspect self()}..."
		send(parent, {:message, "Sending parent a message before dying..."})
		sleep(5000)
		exit(:dead)

	end

	def run do

		# Process.flag(:trap_exit, true)
		spawn_monitor(MonitorAndLink, :send_and_exit, [self()])
		spawn_link(MonitorAndLink, :send_and_exit, [self()])

		sleep(2000)

		receive do
			{:message, message} ->
				IO.puts "SPAWN_MONITOR's Message received: #{inspect message}"
		end

		receive do
			{:message, message} ->
				IO.puts "SPAWN_LINK's Message received: #{inspect message}"
		end

	end

end

# Exercise: WorkingWithMultipleProcesses-3, 4, and 5

# If Process.flag(:trap_exit, true) is not set the program will shut down because it is linked
# Because of this the message will never get sent

# If it is spawn_monitor, the program doesn't shut down because it is not linked
# So a message will be sent.

# If the process is linked and an execption is raised in the child process
# The whole program will shut down
# If the process is only monitored, the parent will be notified and program will continue to run 
MonitorAndLink.run

