Code.load_file("../util/input.ex")

defmodule MultistateTaxCalculator do
  import Input

  def run do
    amount = float_p("What is the order amount? ")
    state = string("What state do you live in? ") |> String.upcase

    state =
      if String.length(state) > 2 do
        case state do
          "WISCONSIN" -> "WI"
          "MINNESOTA" -> "MN"
        end
      else
        state
      end

    tax = tax(state)
    tax = if tax > 0, do: tax * amount, else: tax

    total = Float.round(amount + tax, 3)

    IO.puts "The tax is $#{tax}"
    IO.puts "The total is $#{total}"
  end

  defp tax("IL"), do: 0.08
  defp tax("WI") do
    county = string("What county do you live in? ") |> String.upcase

    case county do
      "EAU CLAIRE" -> 0.005
      "DUNN" -> 0.004
      _ -> 0.0
    end
  end
  defp tax(_), do: 0.0
end

MultistateTaxCalculator.run()
