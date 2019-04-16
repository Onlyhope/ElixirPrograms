defmodule StackServer do
	
	use GenServer

	def init(initial_content) do 
		{:ok, initial_content}
	end

	def handle_call(:pop, _from, []) do
		{:reply, [], []}
	end

	def handle_call(:pop, _from, [head|tail]) do
		{:reply, head, tail}
	end

	def handle_cast({:push, content}, current_content) do
		{:noreply, [content] ++ current_content}
	end

end