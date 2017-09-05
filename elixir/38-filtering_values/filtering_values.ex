defmodule FilteringValues do
  def run do
    even_numbers =
      IO.gets("Enter a list of numbers, separated by spaces: ")
      |> String.trim
      |> split_into_list_of_numbers()
      |> filter_even_numbers()
      |> join_to_string()

    IO.puts "The even numbers are #{even_numbers}."
  end

  defp split_into_list_of_numbers(string), do: String.split(string) |> Enum.map(&String.to_integer(&1))

  defp filter_even_numbers([]), do: []
  defp filter_even_numbers([head | tail]) when rem(head, 2) == 0, do: [head] ++ filter_even_numbers(tail)
  defp filter_even_numbers([_head | tail]), do: filter_even_numbers(tail)

  defp join_to_string(list), do: Enum.join(list, " ")
end

FilteringValues.run()
