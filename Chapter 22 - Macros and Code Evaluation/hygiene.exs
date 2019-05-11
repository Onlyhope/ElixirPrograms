defmodule Scope do
	
	defmacro update_local(val) do
		local = "some value"
		
		result = quote do
			local = unquote(val)
			IO.puts "End of macro body, local = #{local}" # -> Aaron
		end

		IO.puts "In macro definition, local #{local}" # -> some value
		result
	end
end

defmodule Test do
	
	require Scope

	local = 123
	Scope.update_local "Aaron"
	IO.puts "On return, local = #{local}" # -> 123

end