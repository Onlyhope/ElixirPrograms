# Exercise: StringsAndBinaries-7

defmodule CalculateSalesTax do
	def readFile(file) do
		case File.read(file) do
			{:ok, content} -> parseContent(content)
			{:error, reason} -> IO.puts "#{reason}"
		end
	end
	def parseContent(content) do
		IO.puts getLine(content)
	end
	def getLine(""), do: IO.puts "End"
	def getLine(<<line :: bitstring, "\n", rest :: bitstring>>) do
		IO.puts line
	end
end

CalculateSalesTax.readFile("sales.csv");

System.halt(0)