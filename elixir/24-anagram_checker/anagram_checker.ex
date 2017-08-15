Code.load_file("../util/input.ex")

defmodule Anagram do
  import Input

  def run do
    IO.puts "Enter two strings and I'll tell you if they are anagrams: \n"
    string1 = string("Enter the first string: ")
    string2 = string("Enter the second string: ")

    IO.puts "#{string1} and #{string2} are #{anagrams?(check(string1, string2))}anagrams."
  end

  def check(string1, string2) do
    string1
    |> to_charlist
    |> Enum.sort
    ===
    string2
    |> to_charlist
    |> Enum.sort
  end

  defp anagrams?(false), do: "not "
  defp anagrams?(_), do: ""
end

Anagram.run()
