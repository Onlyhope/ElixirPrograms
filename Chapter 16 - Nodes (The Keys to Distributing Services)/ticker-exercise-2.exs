defmodule Ticker do
	
	@interval 2000 #2 seconds
	@name :ticker 

	@doc """
		Spawns a server process that registers
		the PID of this server under the name :ticker.
	"""
	def start do
		pid = spawn(__MODULE__, :generator, [[],[]])
		:global.register_name(@name, pid)
	end

	@doc """
		Registers the client_pid to the server by sending a message
	"""
	def register(client_pid) do
		send(:global.whereis_name(@name), {:register, client_pid})
	end

	def generator([], []) do
		receive do
			{:register, pid} ->
				IO.puts "Registering #{inspect(pid)}"
				generator([pid], [])
			after
				@interval ->
					IO.puts "tick"

					generator([], [])
		end
	end

	@doc """
		Sends out a tick to all its client every 2 seconds.
		Also register clients to the list of processes
	"""
	def generator([head|tail], processed_clients) do
		receive do
			{:register, pid} ->
				IO.puts "Registering #{inspect(pid)}"
				IO.puts "New list: #{inspect(tail ++ [pid])} processed_clients: #{inspect([head] ++ processed_clients)}"
				generator([head] ++ tail ++ [pid], processed_clients)
			after
				@interval ->
					# current_time = :os.system_time(:millisecond)
					IO.puts "tick"

					send(head, {:tick})

					# Re-cursively call generator to tick again
					generator(tail, processed_clients ++ [head])	
		end
	end

	def generator([], processed_clients) do
		generator(processed_clients, [])
	end
end

defmodule Client do

	@doc """
		Spawns a process and register it to Ticker
	"""
	def start do
		pid = spawn(__MODULE__, :receiver, [])
		Ticker.register(pid)
	end

	def receiver do
		receive do
			{:tick} ->
				IO.puts "#{inspect self()} tock in client"
				receiver()
		end
	end

end

# Exercises: Nodes-3

Ticker.start
Client.start
Client.start




