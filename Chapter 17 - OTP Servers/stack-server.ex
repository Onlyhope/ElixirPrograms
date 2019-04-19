defmodule StackServer do
	
	use GenServer

	def init(initial_content) do 
		{:ok, [initial_content]}
	end

	def handle_call(:pop, _from, []) do
		IO.puts "From: #{inspect _from}"
		{:reply, [], []}
	end

	def handle_call(:pop, _from, [head|tail]) do
		IO.puts "From: #{inspect _from}"
		{:reply, head, tail}
	end

	def handle_cast({:push, content}, current_content) do
		{:noreply, [content] ++ current_content}
	end

end