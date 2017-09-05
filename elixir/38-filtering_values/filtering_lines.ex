defmodule FilteringLines do
  def run do
    IO.puts "The even-numbered lines in the file are: "

    read_lines()
    |> split_into_integer_lists()
    |> filter_even_numbered_lines()
    |> print_lines()
  end

  defp read_lines() do
    File.read!("numbers.txt") |> String.split("\n", trim: true)
  end

  defp split_into_integer_lists(lines) do
    Enum.map(lines, fn line ->
      String.split(line) |> Enum.map(&String.to_integer(&1))
    end)
  end

  defp filter_even_numbered_lines([]), do: []
  defp filter_even_numbered_lines([line | lines]) do
    if is_even_numbered?(line) do
      [line] ++ filter_even_numbered_lines(lines)
    else
      filter_even_numbered_lines(lines)
    end
  end

  # defp is_even_numbered?(line), do: Enum.all?(line, &rem(&1, 2) == 0)
  defp is_even_numbered?(line), do: line === filter_even_numbers(line)

  defp filter_even_numbers([]), do: []
  defp filter_even_numbers([head | tail]) when rem(head, 2) == 0, do: [head] ++ filter_even_numbers(tail)
  defp filter_even_numbers([_head | tail]), do: filter_even_numbers(tail)

  defp print_lines(lines), do: Enum.each(lines, fn line -> Enum.join(line, " ") |> IO.puts end)
end

FilteringLines.run()
