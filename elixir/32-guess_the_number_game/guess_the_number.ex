defmodule GuessTheNumber do
  def run do
    init("Let's play Guess the Number.")
  end

  def init(text) do
    IO.puts text

    level()
    |> number()
    |> start()
  end

  defp level do
    read_int("Pick a difficulty level. (1, 2 or 3): ")
  end

  defp number(1), do: Enum.random(1..10)
  defp number(2), do: Enum.random(1..100)
  defp number(3), do: Enum.random(1..1000)
  defp number(_), do: init("Invalid difficulty level.")

  defp start(number) do
    first_guess()
    |> guess(number, 1)
  end

  defp first_guess(), do: read_int("I have my number. What's your guess? ")

  defp new_guess(text, actual, attempts) do
    read_int("#{text}. Guess again: ")
    |> guess(actual, attempts)
  end

  defp guess(:error, actual, attempts), do:
    new_guess("You've entered an invalid input", actual, attempts)

  defp guess(guess, actual, attempts) when actual > guess, do:
    new_guess("Too low", actual, attempts + 1)

  defp guess(guess, actual, attempts) when actual < guess, do:
    new_guess("Too high", actual, attempts + 1)

  defp guess(_guess, _actual, attempts) do
    IO.puts win_msg(attempts)
    play_again()
  end

  defp play_again() do
    option = read("Play again? ")
    if option == "y" do
      init("Starting new game.")
    else
      exit_game()
    end
  end

  defp win_msg(attempts) when attempts > 1, do: "You got it in #{attempts} guesses!"
  defp win_msg(attempts), do: "You got it in only #{attempts} guess! You are an E.T.!!!"

  defp exit_game() do
    IO.puts "Goodbye!"
    System.halt(1)
  end

  defp read(text) do
    IO.gets(text) |> String.trim
  end

  defp read_int(text) do
    with {n, _} <- read(text) |> Integer.parse, do: n
  end
end

GuessTheNumber.run()
