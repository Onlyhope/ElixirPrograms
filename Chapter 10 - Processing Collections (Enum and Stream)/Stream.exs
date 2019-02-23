# Adds 1 to the previous state. fn(x) -> {stream_value, new_state}
Stream.unfold(1, fn(x) -> {x, x+1} end) |> Enum.take(10) |> IO.inspect

# Fibonacci numbers
Stream.unfold({0, 1}, fn {f1,f2} -> {f1, {f2, f1+f2}} end) |> Enum.take(15) |> IO.inspect

# Takes in three parameters
# 1. fn -> File.open!("sample.txt") end
# 2. fn file -> case IO.read(file, :line) do ...
# 3. fn file -> File.close(file) end
Stream.resource(fn -> File.open!("sample.txt") end,
	fn file ->
		case IO.read(file, :line) do
			data when is_binary(data) -> {[data], file}
			_ -> {:halt, file}
		end
	end,
	fn file -> File.close(file) end) |> Enum.to_list |> IO.inspect

defmodule Countdown do
	
	def sleep(seconds) do
		receive do
			after seconds * 1000 -> nil
		end
	end

	def say(text) do
		spawn fn -> :os.cmd('echo #{text}') end
	end

	def timer do
		Stream.resource(
			fn -> # the number of seconds to start of the next minute 
				{_h, _m, s} = :erlang.time
				60 - s - 1
			end,

			fn # wait for the next second, then return its countdown
				0 -> {:halt, 0}
				count -> 
					sleep(1) 
					{ [inspect(count)], count - 1 }
			end,

			fn _ -> nil end # nothing to deallocate
		)
	end

end