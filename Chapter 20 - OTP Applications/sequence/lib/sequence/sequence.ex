defmodule Sequence.Server do
	
	use GenServer

	@vsn "1"

	defmodule State do
		defstruct(current_number: 0, delta: 1)
	end

	# External API

	def start_link(_) do
		GenServer.start_link(__MODULE__, nil, name: __MODULE__)
	end

	def next_number do
		with number = GenServer.call(__MODULE__, :next_number),
		do: "The next number is #{number}"
	end

	def increment_number(delta) do
		GenServer.cast(__MODULE__, {:increment_number, delta})
	end

	def init(_) do
		state = %State{current_number: Sequence.Stash.get()}
		{:ok, state}
	end

	def handle_call(:next_number, _from, state = %{current_number: n}) do
		{:reply, n, %{state | current_number: n + state.delta}}
	end

	def handle_call({:set_number, new_number}, _from, state) do
		{:reply, new_number, %{state | current_number: new_number}}
	end

	def handle_cast({:increment_number, delta}, state) do
		{:noreply, %{state | delta: delta}}
	end

	def format_status(_reason, [_pdict, state]) do
		[data: [{'State', "My Current state is '#{inspect state}', and I'm happy"}]]
	end

	def terminate(_reason, current_number) do
		Sequence.Stash.update(current_number)
	end
end

# {:ok, pid} = GenServer.start_link(Sequence.Server, 100, [debug: [:trace, :statistics]])
# :sys.statistics(pid, :get)
# :sys.trace(pid, true)
# :sys.trace(pid, false)
# :sys.get_status(pid)