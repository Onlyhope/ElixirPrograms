defmodule HotelRoom do
	
	def book(%{name: name, height: height})
	when height > 1.9 do
		IO.puts "Need extra-long bed for #{name}"
	end

	def book(%{name: name, height: height})
	when height < 1.3 do
		IO.puts "Need low shower controls for #{name}"
	end

	def book(person) do
		IO.puts "Need regular bed for #{person.name}"
	end

	def data do
		[
			%{ name: "Grumpy", height: 1.24},
			%{ name: "Dave" , height: 1.88},
			%{ name: "Dopey", height: 1.32},
			%{ name: "Shaquille", height: 2.16},
			%{ name: "Sneezy", height: 1.28}
		]
	end

end

people = [
	%{ name: "Grumpy", height: 1.24},
	%{ name: "Dave" , height: 1.88},
	%{ name: "Dopey", height: 1.32},
	%{ name: "Shaquille", height: 2.16},
	%{ name: "Sneezy", height: 1.28}
]

IO.inspect(for person = %{ height: height } <- people, height < 1.5, do: person)

# for person = %{ height: height } <- people, height < 1.5, do: person
# 1. person = %{ height: height } 
# 2. person <- people, height < 1.5
# 3. person, do: person

data = %{name: "Dave", state: "TX", likes: "Elixir"}

# 1. key = :name
# 2. %{:name => value} = %{name: "Dave", state: "TX", likes: "Elixir"}
# 3. value == "Dave"
# 4. key = :likes
# 5. %{:likes = value} = %{name: "Dave", state: "TX", likes: "Elixir"}
# 6. value == "Elixir"
for key <- [:name, :likes] do
	%{^key => value} = data
	value
end

















