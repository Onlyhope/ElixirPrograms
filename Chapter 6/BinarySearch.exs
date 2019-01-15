defmodule Chop do
  def guess(guess, answer, _.._) when guess == answer do
  	"Answer: #{answer}"
  end
  def guess(guess, answer, first.._) when answer > guess do
  	IO.puts "#{guess} #{first} - #{answer}"
  	guess(guess, first..answer)
  end
  def guess(guess, answer, _..last) when answer < guess do
  	IO.puts "#{guess} #{answer} - #{last}"
  	guess(guess, answer..last)
  end
  def guess(guess, first..last) do
    middle = calcMiddle(first, last)
   	IO.puts "Is it #{middle}? #{first} - #{last}"
   	guess(guess, middle, first..last)
  end
  def calcMiddle(first, last) do
    range = (last - first)
    middle = first + div(range - 1, 2)
  end
end

IO.puts Chop.guess(200, 1..1000)
IO.puts Chop.guess(273, 1..1000)


System.halt(0)