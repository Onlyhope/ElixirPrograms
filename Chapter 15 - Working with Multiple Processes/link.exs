defmodule Link do
	
	import :timer, only: [ sleep: 1 ]

	def sad_function(arg) do
		IO.puts "Arg1: #{inspect arg}"
		sleep 500
		exit(:boom)
	end

	def run do

		Process.flag(:trap_exit, true)
		spawn_link(Link, :sad_function, ["argument_1"])

		receive do
			msg ->
				IO.puts "MESSAGE RECEIVED: #{inspect msg}"
			after 1000 ->
				IO.puts "Nothing happened as far as I am concerned"
		end
	end

end

Link.run