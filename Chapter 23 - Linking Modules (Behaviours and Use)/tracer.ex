defmodule Tracer do

	import IO.ANSI

	defmacro __using__(_opts) do
		quote do
			import Kernel, except: [def: 2]
			import unquote(__MODULE__), only: [def: 2]
		end
	end

	defmacro def({:when, _, [definition, conditions]}, do: content) do
		IO.puts "Definition"
		IO.inspect definition
		IO.puts "Conditions"
		IO.inspect conditions
		IO.puts "Content"
		IO.inspect content

		{name, _, args} = definition

		IO.inspect args

		# Evaluate the conditions
		trace_def(definition, content, conditions)

		# If true, continue normally with definition and results
		

		# If not true, print which condition fails
	end

	defmacro def(definition, do: content) when is_tuple(definition) do
		trace_def(definition, content)
	end

	def trace_def(definition = {name, _, args}, content, conditions) do
		quote do
			Kernel.def(unquote(definition)) do
				case unquote(conditions) do
					true ->
						IO.puts [
							"==> call: ",
							black(), blue_background(),
							"#{Tracer.dump_defn(unquote(name), unquote(args))}",
							default_color(), default_background()
						]

						result = unquote(content)
						IO.puts [
							"<== result: ",
							black(), green_background(),
							"#{inspect result}",
							default_color(), default_background()
						]
						result
					false ->
						IO.puts "Failed conditions with #{inspect unquote(args)}"
				end

			end
		end
	end

	def trace_def(definition = {name, _, args}, content) do
		quote do
			Kernel.def(unquote(definition)) do
				IO.puts [
					"==> call: ",
					black(), blue_background(),
					"#{Tracer.dump_defn(unquote(name), unquote(args))}",
					default_color(), default_background()
				]

				result = unquote(content)
				IO.puts [
					"<== result: ",
					black(), green_background(),
					"#{inspect result}",
					default_color(), default_background()
				]
				result
			end
		end
	end

	def eval(args, conditions) do
		quote do
			IO.puts "Args: #{inspect unquote(args)}"
			IO.puts "Conditions: #{inspect unquote(conditions)}"
		end

	end

	def dump_defn(name, args) do
		"#{name}(#{dump_args(args)})"
	end

	def dump_args(args) do
		args |> Enum.map(&inspect/1) |> Enum.join(", ")
	end

end

defmodule Test do
	use Tracer
	def puts_sum_three(a,b,c), do: a + b + c
	def add_list(list), do: Enum.reduce(list, 0, &(&1 + &2))
	def my_divide(n,d) when d != 0 and d < 10, do: n / d 
end

Test.puts_sum_three(1,2,3)

# Definition
# {:puts_sum_three, [line: 80],
#  [{:a, [line: 80], nil}, {:b, [line: 80], nil}, {:c, [line: 80], nil}]}
# Content
# {:+, [line: 80],
#  [
#    {:+, [line: 80], [{:a, [line: 80], nil}, {:b, [line: 80], nil}]},
#    {:c, [line: 80], nil}
#  ]}

Test.add_list([5,6,7,8])

# Definition
# {:add_list, [line: 81], [{:list, [line: 81], nil}]}
# Content
# {{:., [line: 81], [{:__aliases__, [line: 81], [:Enum]}, :reduce]}, [line: 81],
#  [
#    {:list, [line: 81], nil},
#    0,
#    {:&, [line: 81],
#     [{:+, [line: 81], [{:&, [line: 81], [1]}, {:&, [line: 81], [2]}]}]}
#  ]}

Test.my_divide(30,15)
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



