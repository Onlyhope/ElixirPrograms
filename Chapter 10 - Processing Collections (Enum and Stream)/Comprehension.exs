for << <<b1::size(2), b2::size(3), b3::size(3) >> <- "hello" >> do
	"0#{b1}#{b2}#{b3}"
end
|> IO.inspect

for x <- ~w{cat dog}, into: %{}, do: {x, String.upcase(x) }
|> IO.inspect

for x <- [1,2,3,4,5], into: y, do: x |> IO.inspect

for x <- ~w{cat dog mouse}, into: IO.stream(:stdio, :line), do: "#{x}\n"