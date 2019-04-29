defmodule Sequence.Server do
	
	require Logger

	use GenServer

	@vsn "1"

	# External API

	def start_link(_) do
		GenServer.start_link(__MODULE__, nil, name: __MODULE__)
	end

	def set_number(n) do
		GenServer.call(__MODULE__, {:set_number, n})
	end

	def next_number do
		with number = GenServer.call(__MODULE__, :next_number),
		do: "The next number is #{number}"
	end

	def increment_number(delta) do
		GenServer.cast(__MODULE__, {:increment_number, delta})
	end

	def init(_) do
		state = Sequence.Stash.get()
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

	def code_channge("0", old_state = current_number, _extra) do
		new_state = %State{
			current_number: current_number,
			delta: 1
		}
		Logger.info "Channging code from 0 to 1"
		Logger.info inspect(old_state)
		Logger.info inspect(new_state)
		{:ok, new_state}
	end

	def terminate(_reason, state) do
		Sequence.Stash.update(state)
	end
end

# {:ok, pid} = GenServer.start_link(Sequence.Server, 100, [debug: [:trace, :statistics]])
# :sys.statistics(pid, :get)
# :sys.trace(pid, true)
# :sys.trace(pid, false)
# :sys.get_status(pid)