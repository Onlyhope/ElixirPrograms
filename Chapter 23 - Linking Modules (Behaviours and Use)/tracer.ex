defmodule Tracer do

	def dump_defn(name, args) do
		"{name}(#{dump_args(args)})"
	end

	def dump_args(args) do
		args |> Enum.map(&inspect/1) |> Enum.join(", ")
	end

	defmacro def(definition = {name, _, args}, do: content) do
		quote do
			Kernel.def(unquote(definition)) do
				IO.puts "==> call: #{Tracer.dump_defn(unquote(name), unquote(args))}"
				result = unquote(content)
				IO.puts "<== result: #{inspect result}"
				result
			end
		end
	end

	defmacro __using__(_opts) do
		quote do
			import Kernel, except: [def: 2]
			import unquote(__MODULE__), only: [def: 2]
		end
	end
end

defmodule Test do
	use Tracer
	def puts_sum_three(a,b,c), do: a + b + c
	def add_list(list), do: Enum.reduce(list, 0, &(&1 + &2))
end

Test.puts_sum_three(1,2,3)
Test.add_list([5,6,7,8])

# Exercise: LinkingModulesBeavioursAndUse-1
# In the body of the def macro, there's a quote block that defines
# the actual method. Why does the first call to puts have to unquote
# the values in its interpolation but the second call does not?

# The result is locally scoped and is already a value. While, name
# and args is scope to the macro. It is still a code fragment and must 
# be unquoted, otherwise Elixir will evaluated as function calls or variables

# Exercise: LinkingModules-BehavioursAndUse-2

# The built-in module IO.ANSI defines functions that represent ANSI
# escape sequences. You can use it it to build output than will display
# (for example) colors and bold, inverse, or underlined text (assuming 
# the terminal supports it)
# Explore the module and use it to colorize our tracing's output
# Why does passing a list of strings to IO.puts work?

# It works because it is within a quote block and will be interpreted
# as code to be executed later.

# Exercise: LinkingMOdules-BehavioursAndUse-3

# (Hard) Try adding a method definition with a guard clause to the Test module.
# You'll find that the tracing no longer works.
# Find out why
# See if you can fix it.



