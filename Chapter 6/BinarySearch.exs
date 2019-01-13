defmodule Chop do
  def guess(answer), do: answer
  def guess(guess, range) do
    first..last = range
    IO.puts "Is it #{guess}?"
  end
end

IO.puts Chop.guess(200, 1..1000)