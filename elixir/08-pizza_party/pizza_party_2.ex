Code.load_file("../util/input.ex")

defmodule PizzaParty do
  import Input

  def run do
    people = int_p("How many people? ")
    pieces = int_p("How many pieces each person wants? ")

    result(people, pieces)
  end

  defp result(people, pieces) do
    IO.puts("\n#{people} people, each one wants #{pieces} #{pieces_out(pieces)}.")

    pizzas = div(people * pieces, 8)

    IO.puts("You need to buy #{pizzas} full #{pizzas_out(pizzas)}.")
  end

  defp pieces_out(1), do: "piece"
  defp pieces_out(_pieces), do: "pieces"

  defp pizzas_out(1), do: "pizza"
  defp pizzas_out(_pieces), do: "pizzas"
end

PizzaParty.run()
