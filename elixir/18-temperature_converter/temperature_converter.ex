Code.load_file("../util/input.ex")

defmodule TemperatureConverter do
  import Input

  def run do
    IO.puts "Press C to convert from Fahrenheit to Celsius.\n" <>
                    "Press F to convert from Celsius to Fahrenheit.\n"
    choice = string("Your Choice: ")

    out =
      case choice do
        "C" -> celsius()
        "F" -> fahrenheit()
      end

    IO.puts out
  end

  defp celsius do
    t = int("Please enter the temperature in Fahrenheit: ")
    "The temperature in Celsius is #{f_to_c(t)}"
  end

  defp fahrenheit do
    t = int("Please enter the temperature in Celsius: ")
    "The temperature in Fahrenheit is #{c_to_f(t)}"
  end

  defp f_to_c(f), do: (f - 32) * 5 / 9
  defp c_to_f(c), do: (c * 9 / 5) + 32
end

TemperatureConverter.run()
