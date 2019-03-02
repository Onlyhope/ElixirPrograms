defmodule Issues.TableFormatter do

  import Enum, only: [each: 2, map: 2, map_join: 3, max: 1]
	
  # Rows are the list of issues
  # Headers are attributes of the issues to display
  # Ex: ["number", "created_at", "title"]
	def print_table_for_columns(rows, headers) do
    with 
      # 1. split_into_columns, if success
      # 2. get column_widths from data_by_columns, if success
      # 3. get format by using column_widths, if success
      # 4. Follow the do-block
      data_by_columns = split_into_columns(rows, headers),
      column_widths = widths_of(data_by_columns)
      format = format_for(column_widths)
    do
      puts_one_line_in_columns(headers, format)
      IO.puts(separator(column_widths))
      puts_in_columns(data_by_columns)
    end
	end

  # 
  # Outputs data_by_columns
	def split_into_columns(row, headers) do
		for 
	end

	def printable(str) when is_binary(str), do: str
	def printable(str), do: to_string(str)

	def widths_of(columns) do
		for column <- columns do
			column
			|> map(&String.length/1) |> max
		end
	end

	# Grabs the width of teh column by 
	def format_for(column_widths) do

	end

	def separator(column_widths) do
		map_join(
			column_widths, "-+-",
			fn(width) ->
				List.duplicate("-", width) 
			end)
	end

	def puts_in_columns(data_by_columns, format) do
		data_by_columns
		|> List.zip
		|> map(&Tuple.to_list/1)
		|> each(&puts_one_line_in_columns(&1, format))
	end



	def puts_one_line_in_columns(fields, format) do
		:io.format(format, fields)
	end
end

# :io.format("~-2s|~2s", ["hello", "world"])
# Argument: Format As String, List of Fields
# Output: hello__|__world | Underscore == Space  

# List.zip([[1, "hello"], [2, "world"], [3, "aaron"]])
# Output: [{1, 2, 3}, {"hello", "world", "aaron"}]