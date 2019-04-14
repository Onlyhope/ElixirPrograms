defmodule Ticker do
	
	@interval 2000 #2 seconds
	@name :ticker 
	@first :first_client
	@last :last_client

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

	def generator([]) do
		receive do
			{:register, pid} ->
				IO.puts "Registering #{inspect(pid)} as first"
				:global.register_name(@first, pid)
				generator([pid])
		end
	end

	@doc """
		Sends out a tick to all its client every 2 seconds.
		Also register clients to the list of processes
	"""
	def generator(clients) do
		receive do
			{:register, pid} ->
				IO.puts "Registering #{inspect(pid)} as last"
				:global.register_name(@last, pid)
				# Update the client list that's currently being ran
				generator(clients ++ [pid])
			{:tick} ->
				[head|tail] = clients
				IO.puts "Clients: #{inspect clients}"
				IO.puts "tick -> #{inspect head}"
				send(head, {:tick, tail, []})
				generator(clients)
		end
	end

	def tick() do
		IO.puts "tick"
		:timer.sleep(2000)
		send(:global.whereis_name(@name), {:tick})
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
			{:tick, [], []} ->
				receiver() 
			{:tick, [head|tail], processed_clients} ->
				IO.puts "#{inspect self()} tock in client"
				:timer.sleep(2000)
				IO.puts "#{inspect self()} tick -> #{inspect head}"
				send(head, {:tick, tail, processed_clients ++ [head]})
				receiver()
			{:tick, [], _processed_clients} ->
				IO.puts "#{inspect self()} tock in client"
				receiver()
		end
	end

end

# Exercises: Nodes-4

# Ticker

Ticker.start
Client.start
Client.start
Client.start
Ticker.tick

# Each Client should have a listener for :tick


















































