defmodule CsvSigil do

	def sigil_v(lines, _opts) do
		lines 
		|> String.trim 
		|> String.split("\n")
		|> Enum.map(&String.split(&1, ","))
		|> Enum.map(&to_float(&1))
		|> csv_to_keyword
	end

	def csv_to_keyword(data) do
		[field_names | field_values_list] = data
		pair_up(field_names, field_values_list)
	end

	defp pair_up(field_names, field_values_list) do

		field_names_as_atom = Enum.map(field_names, fn 
			x when is_atom(x) -> x
			x when is_bitstring(x) -> String.to_atom(x)
			x -> 
				IO.puts "Not valid field name #{inspect x}"
				:not_valid_field_name
		end)

		Enum.map(field_values_list, fn
			field_values -> pair_names_and_values(field_names_as_atom, field_values)
		end)

	end

	def pair_names_and_values(field_names, field_values) do
		zip([field_names, field_values], [])
		|> Enum.map(&List.to_tuple(&1))
		|> Keyword.new
	end

	def zip(listOfElements, tuple_acc) do

		{tuple, leftovers} = package_heads(listOfElements)

		any_leftovers? = Enum.reduce(leftovers, false, fn 
			[], acc -> acc
			_, _acc -> true
		end)

		case any_leftovers? do
			true -> zip(leftovers, tuple_acc ++ [tuple])
			false -> tuple_acc ++ [tuple]
		end
		
	end

	defp package_heads(listOfElements) do
		
		heads = Enum.reduce(listOfElements, [], fn 
			[h|_t], acc -> acc ++ [h]
			[], acc -> acc ++ [""]
		end)

		leftovers = Enum.map(listOfElements, fn 
			[_h|t] -> t
			[] -> [] 
		end)

		{heads, leftovers}

	end

	def test_float(list) do
		to_float(list)
	end

	defp to_float(list) when is_list(list) do
		Enum.map(list, &to_float(&1))
	end

	defp to_float(str) do
		str
		|> String.trim
		|> Float.parse
		|> case do
			:error -> str
			{v, _} -> v
		end
	end

end

defmodule Test do
	
	# Exercise: MoreCoolStuff-1

	# Write a sigil ~v that parses multiple lines of comma-separated data,
	# returning a list of where each element is a row of data and each row
	# is a list of values. Don't worry about quoting - just assume each 
	# field is separated by a comma.

	# Exercise: MoreCoolStuff-2

	# The function Float.parse converts leading characters of a string to a float,
	# returning either a tuple containing the value and the rest of the string,
	# or the atom :error.

	# Exercise: MoreCoolStuff-3

	# (Hard) Sometimes the first line of a CSV file is a list of the column names.
	# Update your code to support this, and return the values in each row as a
	# keyword list, using the column names as the keys.

	import CsvSigil

	def csv do
		# ~v"""
		# 1,2,3,3.14
		# cat,dog
		# a,b,c
		# """

		~v"""
		Name,Age,Money
		Aaron Lee, 26, 9421.29
		Rania, 26, 9329.23
		Benjamin, 26, 1924.32
		"""
	end

	def to_float do
		test_float(["1", "2.32", "3.0", " 3.2"])
	end

	def test_pairing do
		pair_names_and_values([:Name, :Age, :Money], ["Aaron", 26, 9325.23])
	end

	def test_edge_cases do
		zip([
				[1, 2, 3, 4, 5],
				["A", "B", "C"],
				[:a, :b, :c, :d]
			], [])
	end

end

IO.inspect Test.to_float
IO.inspect Test.test_pairing
IO.inspect Test.test_edge_cases

IO.puts "Final CSV"
IO.inspect Test.csv

