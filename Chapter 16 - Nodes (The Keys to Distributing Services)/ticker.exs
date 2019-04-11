defmodule Ticker do
	
	@interval 2000 #2 seconds
	@name :ticker 

	@doc """
		Spawns a server process that registers
		the PID of this server under the name :ticker.
	"""
	def start do
		pid = spawn(__MODULE__, :generator, [[]])
		:global.register_name(@name, pid)
	end

	@doc """
		Registers the client_pid to the server by sending a message
	"""
	def register(client_pid) do
		send(:global.whereis_name(@name), {:register, client_pid})
	end

	def generator(clients) do
		receive do
			{:register, pid} ->
				IO.puts "Registering #{inspect(pid)}"
				generator([pid|clients])
			after
				@interval ->
					IO.puts "tick"
					
					# Sends the message tick to all of the clients
					Enum.each(clients, fn client ->
						send(client, {:tick})
					end)	
		end
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