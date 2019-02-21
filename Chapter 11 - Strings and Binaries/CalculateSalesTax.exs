# Exercise: StringsAndBinaries-7

defmodule CalculateSalesTax do
	def readFile(file) do
		case File.read(file) do
			{:ok, content} -> parseContent(String.split(content, "\n", trim: true));
			{:error, reason} -> IO.puts "#{reason}"
		end
	end
	def parseContent(content) do
		content = removeHeaders(content)
		Enum.map(content, &(process_data(&1)))
	end
	def removeHeaders([head|tail]) do
		IO.puts "Headers: " <> head |> String.split(",") |> Enum.map(&(&1 <> " "))
		tail
	end
	def process_data(<<id :: bitstring-size(24), ",:", ship_to :: bitstring-size(16), ",", net_amount :: bitstring>>) do
		{amount, _} = Float.parse(net_amount)
		tax = salesTax(String.to_atom(ship_to))
		amount * tax |> Float.round(2) |> reform(id, ship_to)
	end
	def reform(after_tax, id, ship_to) do
		"#{id},#{ship_to},#{after_tax}"
	end
	def salesTax(state) do
		taxMap = %{	
			NC: 1.085,
			OK: 1.075,
			TX: 1.050,
			MA: 1.060,
			CA: 1.095
		}
		taxMap[state]
	end
	def salesTax() do
		%{	
			NC: 1.085,
			OK: 1.075,
			TX: 1.050,
			MA: 1.060,
			CA: 1.095
		}
	end
end

IO.inspect CalculateSalesTax.readFile("sales.csv");
CalculateSalesTax.salesTax(String.to_atom("NC"))

data = CalculateSalesTax.salesTax()

# Iterates through the map and look for the matching atom :NC
for key <- [String.to_atom("NC")] do
	%{ ^key => value} = data
	IO.inspect value
end

System.halt(0)