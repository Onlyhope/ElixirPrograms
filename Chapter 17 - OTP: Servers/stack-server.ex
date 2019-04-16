defmodule StackServer do
	
	use GenServer

	def init(initial_content) do 
		{:ok, initial_content}
	end

	def handle_call(:pop, _from, current_content) do
		{:reply, current_content, nil}
	end

	def handle_cast({:push, content}, current_content) do
		[content] ++ current_content
	end

end