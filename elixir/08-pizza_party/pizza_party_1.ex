Code.load_file("../util/input.ex")

defmodule PizzaParty do
  import Input

  def run do
    people = int_p("How many people? ")
    pizzas = int_p("How many pizzas do you have? ")

    result(people, pizzas)
  end

  defp result(people, pizzas) do
    IO.puts("\n#{people} people with #{pizzas} pizzas.")

    pieces = div(pizzas * 8, people)
    leftover = rem(pizzas * 8, people)

    IO.puts("Each person gets #{pieces} #{pieces_out(pieces)} of pizza.")
    IO.puts("There are #{leftover} leftover #{pieces_out(leftover)}.")
  end

  defp pieces_out(1), do: "piece"
  defp pieces_out(_pieces), do: "pieces"
end

PizzaParty.run()
