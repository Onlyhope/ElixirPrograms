# Exercise: Functions - 4

# Write a function prefix that takes a string.
# It should return a new function that takes a second string.
# When that second function is called, it will return a string
# containing the first string, a space, and the second string.

join_by_space = fn s1 ->
	fn s2 ->
		"#{s1} #{s2}"
	end
end

aaron = join_by_space.("Aaron")

IO.puts aaron.("Lee")

System.halt(0)
