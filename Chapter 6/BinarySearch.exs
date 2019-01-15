defmodule Chop do
  def guess(guess, answer, first..last) when guess == answer do
  	"Anwer: #{answer}"
  end
  def guess(guess, answer, first..last) when answer > guess do
  	IO.puts "#{guess} #{first} - #{answer}"
  	guess(guess, first..answer)
  end
  def guess(guess, answer, first..last) when answer < guess do
  	IO.puts "#{guess} #{answer} - #{last}"
  	guess(guess, answer..last)
  end
  def guess(guess, first..last) do
  	range = (last - first)
  	middle = first + div(range - 1, 2)
   	IO.puts "Is it #{middle}? #{first} - #{last}"
   	guess(guess, middle, first..last)
  end
end

IO.puts Chop.guess(200, 1..1000)


System.halt(0)