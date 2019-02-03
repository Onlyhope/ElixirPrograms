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
		
	end
end

# Exercise: StringsAndBinaries-1
IO.inspect MyCharacter.printableASCII('CAT')
IO.inspect MyCharacter.printableASCII('j230`c\09dcj')

IO.inspect MyCharacter.anagram?('abc', 'cba')
IO.inspect MyCharacter.anagram?('abc', 'bdb')