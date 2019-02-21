# Exercises: ModulesAndFunctions-7

# Convert a float to a String with two decmial digits
IO.puts :io_lib.format("~.2f", [123.33333])
IO.puts :io_lib.format("~.2f", [123.0])
IO.puts :erlang.float_to_binary(456.101, [decimals: 2])
IO.puts :erlang.float_to_binary(456.333333, [decimals: 2])

# Get the value of an operating-system environment variable
path = System.get_env("PATH")
IO.puts path

# Return the extension component of a file name
File.read "BuiltInModules.exs"