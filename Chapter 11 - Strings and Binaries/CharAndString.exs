defmodule MyCharacter do
	def printableASCII(charList) do
		Enum.all?(charList, (fn (n) -> isPrintable(n) end))
	end
	def isPrintable(char) when char >= 32 and char <= 126 do
		true
	end
	def isPrintable(_) do
		false
	end
	def anagram?(word1, word2) do
		reversed = Enum.reverse(word2)
		reversed == word1
	end
	def calculate(_) do
		"Calculate"
	end
	def center(wordList) do
		max = max_byte_size(wordList, 0)
		printCenterWords(wordList, max)
	end
	def printCenterWords([], _), do: :ok
	def printCenterWords([head | tail], max) do
		centered_word = center_a_word(head, max)
		IO.puts centered_word
		printCenterWords(tail, max)
	end
	def center_a_word(word, max_size) do
		head_length = div(max_size - String.length(word), 2)
		tail_length = max_size - head_length - String.length(word)
		# IO.puts "#{head_length} + #{String.length(word)} + #{tail_length} = #{max_size}"
		x_characters(head_length," ") <> word <> x_characters(tail_length, " ")
	end
	def max_byte_size([], max), do: max
	def max_byte_size([head | tail], max) do
		head_length = String.length(head)
		if head_length > max do
			head_length = max_byte_size(tail, head_length)
		else
			head_length = max_byte_size(tail, max)
		end
	end
	def x_characters(0, _), do: ""
	def x_characters(x, c) do
		c <> x_characters(x-1, c)
	end

	def capitalize_sentences(str), do: capitalize_sentences(String.capitalize(str), <<>>)

	defp capitalize_sentences(<< ". ", tail::binary >>, str) do
		capitalize_sentences(String.capitalize(tail), str <> <<". ">>)
	end

	defp capitalize_sentences(<< head::utf8, tail::binary >>, str) do
		capitalize_sentences(tail, str <> <<head>>)
	end

	defp capitalize_sentences(<< >>, str), do: str
end

# Exercise: StringsAndBinaries-1
IO.inspect MyCharacter.printableASCII('CAT')
IO.inspect MyCharacter.printableASCII('j230`c\09dcj')

# Exercise: StringsAndBinaries-2
IO.inspect MyCharacter.anagram?('abc', 'cba')
IO.inspect MyCharacter.anagram?('abc', 'bdb')

# Exercise: StringsAndBinaries-3

# Joined is actually a list with 'cat' as the head
# Equivalent to [ ['c', 'a', 't'] | ['d', 'o', 'g'] ]
full = 'catdog'
joined = [ 'cat' | 'dog' ]

IO.puts inspect full, charlists: :as_lists
IO.puts inspect joined, charlists: :as_lists

# TODO - Exercise: StringsAndBinaries-4 - See Calculate.exs
# IO.puts calculate('12 + 50') # 62

# Exercise: StringsAndBinaries-5
IO.puts MyCharacter.center(["cat", "zebra", "elephant"])
IO.puts MyCharacter.center(["cat", "zebra", "∂x/∂y", "elephant_train"])

# Exercise: StringsAndBinaries-6
IO.puts MyCharacter.capitalize_sentences("oh. a DOG. woof.")

System.halt(0)
