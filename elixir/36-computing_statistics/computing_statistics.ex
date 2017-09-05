defmodule ComputingStatistics do
  def run do
    print_results(read_lines())
  end

  defp print_results(response_times) do
    numbers = Enum.join(response_times, ", ")
    IO.puts """
            Numbers: #{numbers}
            The average is #{mean(response_times)}.
            The minimum is #{min(response_times)}.
            The maximum is #{max(response_times)}.
            The standard deviation is #{standard_deviation(response_times)}.
            """ |> String.trim
  end

  defp read_lines() do
    File.read!("response_times.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer(&1))
  end

  defp mean(list), do: Enum.sum(list) / Enum.count(list)

  defp min(list),  do: Enum.min(list)

  defp max(list),  do: Enum.max(list)

  defp standard_deviation(list) do
    list
    |> Enum.map(&:math.pow(&1 - mean(list), 2))
    |> mean()
    |> :math.sqrt
  end
end

ComputingStatistics.run()
