defmodule Dictionary do
	
	@name __MODULE__

	## External API

	def start_link,
	do: Agent.start_link(fn -> %{} end, name: @name)

	def add_words(words),
	do: Agent.update(@name, &do_add_words(&1, words))

	## Internal Implementation

	# Add word one by one to the map
	defp do_add_words(map, words),
	do: Enum.reduce(words, map, &add_one_word(&1, &2))

	# Sorts the string before putting it into map
	# If key (the word) doesn't exists,
	# Initialize an array and put the word in it
	# If key (the word) does exists,
	# Add the word to the head of the list
	# Necessary because you can only append a list as tail
	# With [head|tail] syntax
	# Otherwise use current_list ++ [new_element]
	defp add_one_word(word, map),
	do: Map.update(map, signature_of(word), [word], &[word|&1])

	# Sorts the string
	defp signature_of(word),
	do: word |> to_charlist |> Enum.sort |> to_string

end

defmodule WordlistLoader do
	
	def load_from_files(file_names) do
		file_names
		|> Stream.map(fn name -> Task.async(fn -> loud_task(name) end) end)
		|> Enum.map(&Task.await/1)
	end

	defp load_task(file_name) do
		File.stream!(file_name, [], :line)
		|> Enum.map(&String.trim/1)
		|> Dictionary.add_words
	end

end