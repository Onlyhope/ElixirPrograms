defmodule Stack.Stash do
	
	use GenServer

	@me __MODULE__

	def start_link(initial_element) do
		GenServer.start_link(__MODULE__, initial_element, name: @me)
	end

	def get do
		GenServer.call(@me, {:get})
	end

	def update(new_number) do
		GenServer.cast(@me, {:update, new_number})
	end

	def init(initial_element) do
		{:ok, [initial_element]}
	end

	def handle_call({:get}, _from, current_state) do
		{:reply, current_state, current_state}
	end

	def handle_cast({:update, new_state}, _current_state) do
		{:noreply, new_state}
	end

end