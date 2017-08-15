Code.load_file("../util/input.ex")

defmodule PasswordStrengthIndicator do
  import Input

  def run do
    password = string("Enter the password: ")

    IO.puts "The password #{password} is #{result(password)}."
  end

  defp result(pw) do
    cond do
      pw |> fewer_than(8) ->
        cond do
          only_numbers?(pw) -> "very weak"
          only_letters?(pw) -> "weak"
          letters_and_numbers?(pw) -> "normal"
        end
      pw |> at_least(8) ->
        cond do
          letters_and_numbers?(pw) ->
            if special_characters?(pw) do
              "very strong"
            else
              "strong"
            end
        end
    end
  end

  defp fewer_than(pw, n), do: String.length(pw) < n

  defp at_least(pw, n), do: String.length(pw) >= n

  defp only_numbers?(pw) do
    do_all_match?(~r{[0-9]}, pw)
  end

  defp only_letters?(pw) do
    do_all_match?(~r{[a-zA-Z]}, pw)
  end

  defp letters_and_numbers?(pw) do
    do_any_match?(~r{[0-9]}, pw)
  end

  defp special_characters?(pw) do
    do_any_match?(~r{[^0-9^a-z^A-Z]}, pw)
  end

  defp do_all_match?(regex, string) do
    Regex.scan(regex, string)
    |> List.flatten
    |> Enum.count
    == String.length(string)
  end

  defp do_any_match?(regex, string) do
    Regex.scan(regex, string)
    |> List.flatten
    |> Enum.count
    > 0
  end
end

PasswordStrengthIndicator.run()
