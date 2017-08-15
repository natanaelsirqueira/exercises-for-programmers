Code.load_file("../util/input.ex")

defmodule BloodAlcoholCalculator do
  import Input

  def run do
    weigth = float("Enter your weight (in pounds): ")
    gender = string("Enter your gender [M/W]: ")
    number_of_drinks = int_p("Enter the number of drinks: ")
    alcohol_by_volume = float("Enter the amount of alcohol by volume of " <>
                              "\nthe drinks consumend (in ounces): ")
    time_since_last_drink = int_p("Enter the amount of time (hours) since " <>
                                "your last drink: ")

    total_alcohol_consumed = number_of_drinks * alcohol_by_volume

    alcohol_distribution_ratio =
      case gender do
        "M" -> 0.73
        "W" -> 0.66
      end

    bac = bac(total_alcohol_consumed, weigth, alcohol_distribution_ratio,
              time_since_last_drink)

    IO.puts "\nYour BAC is #{bac}"
    IO.puts result(bac)
  end

  defp bac(a, w, r, h) do
    (a * 5.14 / w * r) - 0.015 * h
  end

  defp result(bac) when bac >= 0.08, do: "It is not legal for you to drive."
  defp result(_bac), do: "You can drive."
end

BloodAlcoholCalculator.run()
