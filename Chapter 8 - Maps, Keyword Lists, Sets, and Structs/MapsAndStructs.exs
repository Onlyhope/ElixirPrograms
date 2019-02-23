defmodule Subscriber do 
	defstruct name: "", paid: false, over_18: true
end

# Struct is wrapped around with a module because it is implied
# since struct is a known data type it can have extra 
# functionality with it.
# Will play a large role when implementing polymorphism
defmodule Attendee do
	defstruct name: "", paid: false, over_18: true

	def may_attend_after_party(attendee = %Attendee{}) do
		attendee.pain && attendee.over_18
	end

	def print_vip_badge(%Attendee{name: name})
	when name != "" do
		IO.puts "Very cheap badge for #{name}"
	end

	def print_vip_badge(%Attendee{}) do
		raise "Missing name for badge"
	end
end

defmodule Customer do
	defstruct name: "", company: ""
end

defmodule BugReport do
	defstruct owner: %Customer{}, details: "", severity: 1
end

report = %BugReport{
	owner: %Customer{
		name: "Dave",
		company: "Pragmatic"
	},
	details: "broken"
}