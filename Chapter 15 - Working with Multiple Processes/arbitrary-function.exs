defmodule ArbitraryFunction do
	
	def main(scheduler) do

		send(scheduler, {:ready, self()})

		receive do
			{:main, n, client} ->
				send(client, {:answer, n, plus_one(n), self()})
				main(scheduler)
			{:shutdown} ->
				exit(:normal)
		end
	end

	defp plus_one(n), do: n + 1

end