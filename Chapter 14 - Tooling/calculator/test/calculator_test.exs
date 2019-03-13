defmodule TestStats do
	use ExUnit.Case
  doctest MyCalculator

	@doc """

	Add function

  ## Examples

    iex> MyCalculator.sum(2,3)
    7

	"""
	test "calculates sum" do
		x = 2
		y = 3
		assert MyCalculator.add(x,y) == 5
	end

  @doc """

  Subtract function

  """
  test "calculates multiplication" do
    x = 5
    y = 2
    assert MyCalculator.subtract(x,y) == 3
  end
	
end