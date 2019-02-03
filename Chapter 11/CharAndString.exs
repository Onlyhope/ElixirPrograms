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
	def calculate(expr) do
		"Calculate"
	end
	def center(wordList) do
		max = max_byte_size(wordList, 0)
		# center(wordList, max, [])
	end
	def max_byte_size([], max), do: max
	def max_byte_size([head | tail], max) when (byte_size head) > max do
		IO.puts "max < #{byte_size head}"
		max_byte_size(tail, byte_size head)
	end
	def max_byte_size([head | tail], max) do
		IO.puts "max > #{byte_size head}"
		center(tail, max)
	end

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

# Exercise: StringsAndBinaries-4
# IO.puts calculate('12 + 50') # 62

# Exercise: StringsAndBinaries-5
IO.puts MyCharacter.center(["cat", "zebra", "elephant"])

