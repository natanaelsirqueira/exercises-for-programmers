Code.load_file("table_formatter.ex")

defmodule ParsingDataFile do
  def run do
    "data.csv"
    |> read_file()
    |> parse_data()
    |> print_table()
  end

  def read_file(path) do
    path
    |> File.read!()
    |> String.trim()
    |> String.split("\n")
  end

  def parse_data(data) do
    data
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(&Enum.zip(headers(), &1))
    |> Enum.map(&Enum.into(&1, %{}))
    |> Enum.sort_by(& &1["Salary"], &>=/2)
    |> Enum.map(fn person -> update_in(person["Salary"], &format_currency/1) end)
    |> pad_currency()
  end

  def print_table(data) do
    TableFormatter.print_table_for_columns(data, headers())
  end

  defp headers, do: ~w[Last First Salary]

  defp format_currency(salary) do
    [int_salary, cents] = String.split(salary, ".")

    formatted_salary =
      int_salary
      |> String.graphemes()
      |> Enum.reverse()
      |> Enum.chunk_every(3, 3, [])
      |> Enum.reverse()
      |> Enum.map(&Enum.reverse(&1) |> Enum.join())
      |> Enum.join(",")

    "$#{formatted_salary}.#{cents}"
  end

  defp pad_currency(data) do
    column_width =
      data
      |> Stream.map(&String.length(&1["Salary"]))
      |> Enum.max()

    Enum.map(data, fn person ->
      Map.update!(person, "Salary", &String.pad_leading(&1, column_width))
    end)
  end
end

ParsingDataFile.run()
