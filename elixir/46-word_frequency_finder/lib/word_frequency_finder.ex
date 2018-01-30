defmodule WordFrequencyFinder do
  def run(file_path) do
    file_path
    |> File.stream!()
    |> Flow.from_enumerable()
    |> Flow.flat_map(&extract_words/1)
    |> Flow.partition()
    |> Flow.reduce(fn -> %{} end, fn word, acc ->
         Map.update(acc, word, 1, &(&1 + 1))
       end)
    |> Enum.sort_by(&elem(&1, 1), &>=/2)
    |> Enum.map(&Tuple.to_list/1)
  end

  def run_sync(file_path) do
    file_path
    |> File.stream!()
    |> Stream.flat_map(&extract_words/1)
    |> Enum.reduce(%{}, fn word, acc ->
         Map.update(acc, word, 1, &(&1 + 1))
       end)
    |> Enum.sort_by(&elem(&1, 1), &>=/2)
    |> Enum.map(&Tuple.to_list/1)
  end

  defp extract_words(row) do
    row
    |> String.trim()
    |> String.split()
    |> Stream.map(&Regex.replace(~r/[^\w\s]/, &1, ""))
    |> Stream.map(&String.downcase/1)
  end
end
