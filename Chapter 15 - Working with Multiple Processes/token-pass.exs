# Exercise: WorkingWithMultipleProcesses-2
defmodule TokenPass do

	@moduledoc """
	This program will send and receive token in an infinite loop! 
	"""
	
	def receive_token do
		receive do
			{:token, token, sender} ->
				IO.inspect sender
				IO.puts "Hi, I've received your #{token}"
				send(sender, {:message, "Send me another token please!", self()})
				:timer.sleep(1000)
			{:message, message, sender} ->
				IO.inspect sender
				IO.puts "Receiving message... #{message}"
				IO.puts "Will do!"
				send(sender, {:token, "ANOTHER_TOKEN", self()})
				:timer.sleep(1000)
		end
		receive_token()
	end

end

self()
|> IO.inspect
process_one = spawn(TokenPass, :receive_token, [])
|> IO.inspect
process_two = spawn(TokenPass, :receive_token, [])
|> IO.inspect

send(process_one, {:token, "A_TOKEN", process_two})

