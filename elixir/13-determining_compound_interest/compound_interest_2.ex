Code.load_file("../util/input.ex")

defmodule CompoundInterest do
  import Input

  def run do
    final_amount = int_p("What is the amount you want to reach out? ")
    rate = float("What is the rate? ")
    years = int_p("What is the number of years? ")
    times = int_p("What is the number of times the interest" <>
                "\nis compounded per year? ")

    initial_amount = calculate_initial_amount(final_amount, rate, years, times)

    IO.puts "\nIn order to reach the amount of $#{final_amount} at #{rate}%" <>
            "\nfor #{years} years compounded #{times} times per year, " <>
            "\nyou need to invest $#{initial_amount}.\n"
  end

  defp calculate_initial_amount(final_amount, rate, years, times) do
    Float.round(final_amount / :math.pow(1 + ((rate / 100) / times), times * years), 2)
  end
end

CompoundInterest.run()
