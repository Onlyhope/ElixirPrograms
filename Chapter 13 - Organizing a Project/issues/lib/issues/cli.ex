defmodule Issues.CLI do
	
	@default_count 4

	@moduledoc """
	Handle the command line parsing and the dispatch to
	the various functions that end up generating a
	table of the last _n_issues in a github project
	"""

  import Issues.TableFormatter

	def main(argv) do
		argv
		|> parse_args
		|> process
	end

	def process(:help) do
		IO.puts """
		usage: issues <user> <project> [ count | #{@default_count} ]
		"""
	end

	def process({user, project, count}) do
		Issues.GithubIssues.fetch(user, project)
		|> decode_response()
		|> sort_into_descending_order()
    |> last(count)
    |> print_table_for_columns(["number", "created_at", "title"])
	end

  def decode_response({:ok, body}), do: body

  def decode_response({:error, error}) do
    IO.puts "Error fetching from Github: #{error["message"]}"
    System.halt(2)
  end

	def sort_into_descending_order(list_of_issues) do
		list_of_issues
		|> Enum.sort(fn(i1, i2) -> 
			i1["created_at"] >= i2["created_at"]
			end)
	end

  def last(list, count) do
    list
    |> Enum.take(count)
    |> Enum.reverse
  end

  # Naive implementation of Format_Issues_Into_Table
  def format_issues_into_table(issues) do
    """
    #    | created_at           | title
    #{parse_issues(issues)}
    """
    |> IO.puts
  end

  def parse_issues(issues) do
    # Parse each list in issues
    issues
    |> Enum.map(&transform_data/1)
    |> Enum.join("\n")
  end

  defp transform_data(issue) do
    "#{Map.get(issue, "number")}"
    <> " | #{Map.get(issue, "created_at")}"
    <> " | #{Map.get(issue, "title")}"
  end

	@doc """
	`argv` can be -h or --help, which returns :help

	Otherwise it is a github user name, project name, and (optionally)
	the number of entries to format.

	Return a tuple of `{ user, project, count }`
	"""

	def parse_args(argv) do
		OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
		|> elem(1)
		|> args_to_internal_representation()
	end

	def args_to_internal_representation([user, project, count]) do
		{ user, project, String.to_integer(count) }
	end

	def args_to_internal_representation([user, project]) do
		{ user, project, @default_count }
	end

	def args_to_internal_representation(_) do # bad arg or --help
		:help
	end

end






























