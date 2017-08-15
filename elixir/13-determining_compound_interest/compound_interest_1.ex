Code.load_file("../util/input.ex")

defmodule CompoundInterest do
  import Input

  def run do
    principal = int_p("What is the principal amount? ")
    rate = float("What is the rate of interest? ")
    years = int_p("What is the number of years? ")
    times = int_p("What is the number of times the interest" <>
                "\nis compounded per year? ")

    final_amount = calculate_compound_interest(principal, rate, years, times)

    IO.puts "\n$#{principal} invested at #{rate}% for #{years} years" <>
            "\ncompounded #{times} times per year is $#{final_amount}.\n"
  end

  defp calculate_compound_interest(principal, rate, years, times) do
    Float.round(principal * :math.pow(1 + ((rate / 100) / times), times * years), 2)
  end
end

CompoundInterest.run()
