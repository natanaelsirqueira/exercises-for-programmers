Code.load_file("../util/input.ex")

defmodule PickingWinner do
  import Input

  def run do
    contestants = read_names([])
    choose_winner(contestants)
  end

  defp read_names(names) do
    name = string("Enter a name: ") |> String.trim

    if String.length(name) == 0 do
      names
    else
      read_names([name | names])
    end
  end

  defp choose_winner(contestants) do
    if length(contestants) > 0 do
      winner = Enum.random(contestants)
      IO.puts "The winner is... #{winner}"

      option = string("Do you want to choose another winner? [Y/N]: ")
      if String.upcase(option) == "Y" do
        contestants
        |> List.delete(winner)
        |> choose_winner()
      else
        IO.puts "Program finished."
      end
    else
      IO.puts "There are no more contestants available."
    end
  end
end

PickingWinner.run()
