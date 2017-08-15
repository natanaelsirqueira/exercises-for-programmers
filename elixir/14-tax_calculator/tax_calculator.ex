Code.load_file("../util/input.ex")

defmodule TaxCalculator do
  import Input

  def run do
    amount = float_p("What is the order amount? ")
    state = string("What is the state? ") |> String.upcase

    state =
      if String.length(state) > 2 do
        case state do
          "WISCONSIN" -> "WI"
          "MINNESOTA" -> "MN"
        end
      end

    tax =
      case state do
        "WI" -> amount * 5.5 / 100
        "MN" -> 0.0
      end

    total = Float.round(amount + tax, 3)

    result(amount, state, tax, total)
  end

  defp result(amount, "WI", tax, total) do
    print("subtotal", amount)
    print("tax", tax)
    print("total", total)
  end

  defp result(_amount, "MN", _tax, total) do
    print("total", total)
  end

  defp print(string, value) do
    IO.puts "The #{string} is #{value}"
  end
end

TaxCalculator.run()
