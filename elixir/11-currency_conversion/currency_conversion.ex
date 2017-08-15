Code.eval_file("../util/input.ex")

defmodule CurrencyConversion do
  import Input

  def run do
    amount = float_p("What is the amount you are exchanging? ")
    iso = string("What is the ISO? ")
    rate = get_rate(iso)
    IO.puts "#{amount} #{iso} at an exchange rate of #{rate} is " <>
            "#{dollars(amount, rate)} U.S. dollars."
  end

  defp dollars(amount, rate) do
    (amount * rate) / get_rate("USD")
  end

  File.read!("./rates.txt")
  |> String.split("\n", trim: true)
  |> Enum.map(&String.split(&1, "|"))
  |> Enum.map(fn [iso, rate] ->
    rate = String.to_float(rate)

    defp get_rate(unquote(iso)), do: unquote(rate)
  end)
end

CurrencyConversion.run()
