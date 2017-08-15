Code.load_file("../util/input.ex")

defmodule SimpleInterest do
  import Input

  def run do
    principal = int_p("Enter the principal: ")
    rate = float("Enter the rate of interest: ")
    years = int_p("Enter the number of years: ")

    final_amount = calculate_simple_interest(principal, rate, years)

    IO.puts "\nAfter #{years} years at #{rate}%, the investment will" <>
            "\nbe worth $#{final_amount}.\n"

    Enum.each(1..years, fn n ->
      partial_amount = calculate_simple_interest(principal, rate, n)
      IO.puts "At the end of year #{n}, the investment will be worth $#{partial_amount}."
    end)
  end

  defp calculate_simple_interest(principal, rate, years) do
    (principal * (1 + ((rate / 100) * years)))
    |> Float.ceil
    |> round
  end
end

SimpleInterest.run()
