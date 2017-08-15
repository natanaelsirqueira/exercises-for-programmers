Code.load_file("../util/input.ex")

defmodule ComparingNumbers do
  import Input

  def run do
    numbers = new_number([])

    IO.puts "The largest number is #{max(numbers)}."
  end

  def new_number(numbers) do
    num = int("Enter a number: ")

    if num in number do
      IO.puts "You've alreay entered this number."
      new_number(numbers)
    else
      op = string("Do you want to add another number? [Y/N] ")
      if (op == "N") do
        [num | numbers]
      else
        new_number([num | numbers])
      end
    end
  end

  def max([a]), do: a
  def max([head | tail]), do: greater(head, max(tail))

  defp greater(a, b) when a > b, do: a
  defp greater(a, b) when b > a, do: b
end

ComparingNumbers.run()
