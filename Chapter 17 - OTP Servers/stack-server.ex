defmodule StackServer do
	
	use GenServer

	def init(initial_content) do 
		{:ok, [initial_content]}
	end

	def handle_call(:pop, _from, []) do
		{:reply, [], []}  #{:reply, result, new_state}
	end

	def handle_call(:pop, _from, [head|tail]) do
		{:reply, head, tail} #{:reply, result, new_state}
	end

	def handle_cast({:push, content}, current_content) do
		{:noreply, [content] ++ current_content} #{:noreply, new_state}
		# Can also return {:stop, reason, new_state}
	end

	# handle_call(request, from, state)
	# handle_cast(request, state)
	# handle_info(info, state)
	# terminate(reason, state)
	# code_change(from_version, state, extra)
	# format_status(reason, [pdict, state])

end