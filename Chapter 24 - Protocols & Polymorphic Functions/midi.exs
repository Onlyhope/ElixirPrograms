defmodule Midi do
	
	defstruct(content: <<>>)

	defmodule Frame do
		
		defstruct(
			type: "xxxx",
			length: 0,
			data: <<>>
		)

		def to_binary(%Midi.Frame{type: type, length: length, data: data}) do
			<<
				type::binary-4,
				length::integer-32,
				data::binary
			>>
		end

	end

	def from_file(name) do
		%Midi{content: File.read!(name)}
	end	

end

defimpl Enumerable, for: Midi do

	def reduce(%Midi{content: content}, state, fun) do
		_reduce(content, state, fun)
	end

	def _reduce(_content, {:halt, acc}, _fun) do
		{:halted, acc}
	end

	def _reduce(content, {:suspended, acc}, fun) do
		{:suspended, acc, &_reduce(content, &1, fun)}
	end

	def _reduce(_content = "", {:cont, acc}, _fun) do
		{:done, acc}
	end

	def _reduce(
		<<
			type::binary-4,
			length::integer-32,
			data::binary-size(length),
			rest::binary
		>>,
		{:cont, acc},
		fun
	) do
		frame = %Midi.Frame{type: type, length: length, data: data}
		_reduce(rest, fun.(frame, acc), fun)				
	end

	def count(midi = %Midi{}) do
		frame_count = Enum.reduce(midi, 0, fn (_, count) -> count + 1 end)
		{:ok, frame_count}
	end

	def member?(midi = %Midi{}, %Midi.Frame{}) do
		{:error, __MODULE__}
	end		

	def slice(%Midi{}) do
		{:error, __MODULE__}
	end

end

defimpl Collectable, for: Midi do

	use Bitwise

	def into(%Midi{content: content}) do
		{
			content,
			fn
				acc, {:cont, frame = %Midi.Frame{}} ->
					acc <> Midi.Frame.to_binary(frame)

				acc, :done ->
					%Midi{content: acc}

				_, :halt ->
					:ok
			end
		}
	end
end

# Definining implementations for the protocols Collectable and Enumerable
# over structs allows you to treat them as streams and use the Enum interface.

# Implementing into from Collectable allows you to turn a list of the element
# into a stream to be operated by Enum.
