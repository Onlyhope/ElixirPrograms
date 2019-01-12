defmodule Greeter do 
	def greet(greeting, name), do: (
		IO.puts greeting
		IO.puts "How're you doing, #{name}?"
	)
end

Greeter.greet("Hello", "Aaron")

System.halt(0)