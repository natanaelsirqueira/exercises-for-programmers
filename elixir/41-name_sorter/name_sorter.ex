defmodule NameSorter do
  def run do
    read_names([])
    |> Enum.sort()
    |> save_to_file()
  end

  def read_names(names) do
    case IO.gets("") |> String.trim do
      "stop" -> names
      name   -> read_names([name | names])
    end
  end

  def save_to_file(names) do
    content = Enum.join(names, "\n")

    File.write("names.txt", content)
  end
end

NameSorter.run()
