Code.load_file("../util/input.ex")

defmodule PasswordGenerator do
  import Input

  def run do
    min_length = int("What's the minimum length? ")
    special_chars = int("How many special characters? ")
    numbers = int("How many numbers? ")

    IO.puts "Here are some options: "
    Enum.each(1..Enum.random(3..10), fn _ ->
      IO.puts generate_password(min_length, special_chars, numbers)
    end)
  end

  def generate_password(min_length, special_chars, numbers) do
    possible_characters = ~w[! @ # $ &]
    possible_letters = Enum.into(?A..?Z, []) ++ Enum.into(?a..?z, [])

    l = min_length - (special_chars + numbers)
    letters = Enum.random(l..20)

    numbers = Enum.map(1..numbers, fn _ -> Enum.random(0..9) end)
    letters = Enum.map(1..letters, fn _ -> Enum.random(possible_letters) end)
    special = Enum.map(1..special_chars, fn _ -> Enum.random(possible_characters) end)

    (Enum.map(letters, &to_string([&1])) ++ numbers ++ special)
    |> Enum.shuffle
    |> Enum.map(fn i ->
      if i in ~w[A E I O], do: (if :rand.uniform(2) == 1, do: leet(i)), else: i
    end)
    |> Enum.join
  end

  defp leet("A"), do: 4
  defp leet("E"), do: 3
  defp leet("I"), do: 1
  defp leet("O"), do: 0
  defp leet(char), do: char
end

PasswordGenerator.run()
