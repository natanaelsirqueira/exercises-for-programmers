Code.load_file("../util/input.ex")

defmodule BMICalculator do
  import Input

  def run do
    unit = string("Do you want to use Imperial or Metric units? [I/M] ")

    bmi =
      case unit do
        "I" -> imperial()
        "M" -> metric()
      end
      |> Float.round(2)

    IO.puts "\nYour BMI is #{bmi}"
    IO.puts result(bmi)
  end

  defp imperial do
    h_unit = string("Do you want to use feet or inches? [F/I] ")

    weight = get_weight_in("pounds")

    if h_unit == "F" do
      height = get_height_in("feet")
      bmi(weight, height, 4.88)
    else
      height = get_height_in("inches")
      bmi(weight, height, 703)
    end
  end

  defp metric do
    weight = get_weight_in("kilograms")
    height = get_height_in("meters")

    bmi(weight, height)
  end

  defp get_weight_in(unit), do: float_p("Enter your weight in #{unit}: ")
  defp get_height_in(unit), do: float_p("Enter your height in #{unit}: ")

  defp bmi(weight, height, factor \\ 1), do: (weight / (height * height)) * factor

  defp result(bmi) when bmi >= 18.5 and bmi < 25 do
    "You are within the ideal weight range."
  end

  defp result(bmi) when bmi < 18.5 do
    "You are underweight. You should see a doctor."
  end

  defp result(bmi) when bmi > 25 do
    "You are overweight. You should see a doctor."
  end
end

BMICalculator.run()
