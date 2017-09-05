Code.load_file("../util/input.ex")

defmodule EmployeeListRemoval do
  import Input
  
  def run do
    list = read_lines()
    print_names(list)
    name = string("Enter an employee name to remove: ")

    if name in list do
      list = List.delete(list, name)
      write_lines(list)
      print_names(list)
    else
      IO.puts "This name does not exist in the list."
    end
  end

  defp print_names(list) do
    IO.puts("There are #{length(list)} employees:")
    Enum.each(list, &IO.puts&1)
  end

  defp read_lines(), do: File.read!("employee_list.txt") |> String.split("\n", trim: true)

  defp write_lines(list), do: File.write!("employee_list.txt", Enum.join(list, "\n"))
end

EmployeeListRemoval.run()
