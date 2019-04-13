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

	@doc """
		Sends out a tick to all its client every 2 seconds.
		Also register clients to the list of processes
	"""
	def generator([head|tail], processed_clients) do
		receive do
			{:register, pid} ->
				IO.puts "Registering #{inspect(pid)}"
				generator([pid|tail], processed_clients)
			after
				@interval ->
					# current_time = :os.system_time(:millisecond)
					IO.puts "#{inspect :os.system_time(:millisecond)} tick"
					
					# Sends the message tick to all of the clients
					# Enum.each(clients, fn client ->
					# 	send(client, {:tick})
					# end)

					send(head, {:tick})

					# Re-cursively call generator to tick again
					generator(tail, processed_clients + [head])	
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
				IO.puts "tock in client"
				receiver()
		end
	end

end

# Exercises: Nodes-1

# Window 1: iex --sname node_1
# Window 2: iex --sname node_2
# Window 2: Node.connect :"node_1"

fun = fn -> IO.puts(Enum.join(File.ls!, ",")) end

# Exercises: Nodes-2
# When I introduced the interval server, I said it sent a tick
# "about every 2 seconds." But in the receive loop, it has an
# explicit timeout of 2,000 ms. Why did I say "about" when it
# looks as if the time should be pretty accurate?

# Because there's an interval between calling itself and sending
# each registered client a message. (Not satisfied with this answer)

# Exercises: Nodes-3

Ticker.start


