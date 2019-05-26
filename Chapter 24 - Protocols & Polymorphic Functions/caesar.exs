defprotocol Caesar do
	@fallback_to_any true
	def encrypt(string, shift)
	def rot13(string)
end

defimpl Caesar, for: [BitString] do
	def encrypt(string, shift) do
		"String is a bitString"
	end
end

defimpl Caesar, for: [List] do
	def encrypt(string, shift) do
		"String is a list"
	end
end

defimpl Caesar, for: Any do
	def encrypt(string, shift), do: "Not a valid string"
end

# Exercise: Protocols-1
# A basic Caesar cypher consists of shifting the letters in a message
# by a fixed offset. For an example with offset 1, zab -> abc.
# If the offset is 13, we have the ROT13 algorithm.

# Lists and binaries can be string like. Write a Caesar protocol
# that applies to both. It would include two functions:
# encrypt(string, shift) and rot13(string)

IO.inspect Caesar.encrypt("123", 1)
IO.inspect Caesar.encrypt('123', 1)
IO.inspect Caesar.encrypt('123', "123")
IO.inspect Caesar.encrypt(123, 1)

# Exercise: Protocols-2
# Using a list of wrods in your language, write a program to look
# for words where the result of calling rot13(word) is also a word in the list.