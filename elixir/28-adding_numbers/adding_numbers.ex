Code.load_file("../util/input.ex")

defmodule AddingNumbers do
  import Input

  def run do
    numbers = int_p("How many numbers will be entered? ")

    total =
      numbers
      |> get_numbers
      |> Enum.filter(fn(n) -> n != 0 end)
      |> sum

    IO.puts "The total is #{total}"
  end

  defp get_numbers(t) do
    Enum.map(1..t, fn(_n) ->
      IO.gets("Enter a number: ")
      |> Integer.parse
      |> validate
    end)
  end

  defp validate({x, _}) when is_number(x), do: x
  defp validate(:error), do: 0

  defp sum([]), do: 0
  defp sum([h | t]), do: h + sum(t)
end

AddingNumbers.run()
