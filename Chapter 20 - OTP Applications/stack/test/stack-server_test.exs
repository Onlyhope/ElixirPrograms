defmodule Stack.ServerTest do

	# Test doens't work if file doesn't end with "_test"
	
	use ExUnit.Case
	alias Stack.Server

	test "Initial state of Stack Server" do
		initial_state = Server.pop()
		assert(initial_state == nil)
	end

	test "push and pop" do
		Server.push(1)
		Server.push(2)
		Server.push(3)

		assert(Server.pop() == 3)
		assert(Server.pop() == 2)
		assert(Server.pop() == 1)
	end

end