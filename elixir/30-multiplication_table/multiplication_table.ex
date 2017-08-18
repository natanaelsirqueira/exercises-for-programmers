Code.load_file("table_formatter.ex")

defmodule MultiplicationTable do
  import TableFormatter

  def run do
    print(table_of(0..12))
  end

  defp table_of(range) do
    for n <- range,
        p <- range,
        do: {n, p, n * p}
  end

  defp print(table) do
    table
    |> Enum.group_by(fn {n, _p, _r} -> n end, fn {_n, p, r} -> {p, r} end)
    |> Enum.map(fn {n, rs} ->
      rs
      |> Enum.map(fn {p, r} -> {to_string(p), to_string(r)} end)
      |> Enum.into(%{})
      |> Map.put("", to_string(n))
    end)
    |> print_table_for_columns(["" | Enum.map(0..12, &to_string/1)])
  end
end

MultiplicationTable.run()
