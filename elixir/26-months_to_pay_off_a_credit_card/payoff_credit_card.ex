Code.load_file("../util/input.ex")

defmodule PayOffCreditCard do
  import Input

  def run() do
    balance = float_p("What is your balance? ")
    apr = float_p("What is the APR on the card (as a percent)? ")
    payment = float_p("What is the monthly payment you can make? ")

    IO.puts "It will take you #{result(balance, apr, payment)} months " <>
            "to pay off this card."
  end

  def result(b, apr, p) do
    i = apr / 36500

    n = -(1/30) * :math.log10(1 + (b/p) * (1 - :math.pow((1 + i), 30) ) )
                  / :math.log10(1 + i)

    Float.ceil(n) |> round
  end
end

PayOffCreditCard.run()
