defmodule Chop do
  def guess(guess,  first..last) when guess == div(first + last, 2) do
  	IO.puts "Answer: #{div(first + last, 2)}"
  end
  def guess(guess, first..last) when div(first + last, 2) > guess do
  	guess(guess, first..div(first+last, 2))
  end
  def guess(guess, first..last) when div(first + last, 2) < guess do
  	guess(guess, div(first+last, 2)..last)
  end
end

IO.puts Chop.guess(999, 1..1000)
IO.puts Chop.guess(200, 1..1000)
IO.puts Chop.guess(273, 1..1000)
IO.puts Chop.guess(572, 1..1000)
IO.puts Chop.guess(759, 1..1000)
IO.puts Chop.guess(1, 1..1000)

System.halt(0)