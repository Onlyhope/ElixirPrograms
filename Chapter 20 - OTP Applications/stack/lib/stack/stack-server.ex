defmodule Stack.Server do
	
	use GenServer

	@server __MODULE__

	def serverName do
		@server
	end

	def start_link(_) do
		GenServer.start_link(Stack.Server, Stack.Stash.get, name: @server)
	end

	def pop do
		GenServer.call(@server, :pop)
	end

	def push(content) do
		GenServer.cast(@server, {:push, content})
	end

	def stop(reason) do
		GenServer.cast(@server, {:stop, reason})
	end

	def init(initial_content) do 
		{:ok, [initial_content]}
	end

	def handle_call(:pop, _from, []) do
		{:reply, nil, []}  #{:reply, result, new_state}
	end

	def handle_call(:pop, _from, [head|tail]) do
		{:reply, head, tail} #{:reply, result, new_state}
	end

	def handle_cast({:push, content}, current_content) do
		{:noreply, [content] ++ current_content} #{:noreply, new_state}
		# Can also return {:stop, reason, new_state}
	end

	def handle_cast({:stop, reason}, current_state) do
		{:stop, reason, current_state}
	end

	def terminate(_reason, state) do
		Stack.Stash.update(state)
	end

	# handle_call(request, from, state)
	# handle_cast(request, state)
	# handle_info(info, state)
	# terminate(reason, state)
	# code_change(from_version, state, extra)
	# format_status(reason, [pdict, state])

end