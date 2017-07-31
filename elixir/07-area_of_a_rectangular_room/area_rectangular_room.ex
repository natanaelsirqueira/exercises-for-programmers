Code.load_file("../util/input.ex")

defmodule AreaRectangularRoom do
  import Input

  @conversion_factor 0.09290304

  def run do
    string("You'll be entering feet or meters? [F/M]: ") |> result()
  end

  defp result("F") do
    length = float_p("What is the length of the room in feet? ")
    width = float_p("What is the width of the room in feet? ")

    print_result("feet", length, width)
  end

  defp result("M") do
    length = float_p("What is the length of the room in meters? ")
    width = float_p("What is the width of the room in meters? ")

    print_result("meters", length, width)
  end

  defp result(_), do: "Invalid input."

  defp print_result("feet", length, width) do
    IO.puts "You entered dimensions of #{length} feet by #{width} feet."
    square_feet = area(length, width)
    square_meters = Float.round(square_feet * @conversion_factor, 3)
    IO.puts "The area is \n#{square_feet} square feet \n#{square_meters} square meters"
  end

  defp print_result("meters", length, width) do
    IO.puts "You entered dimensions of #{length} meters by #{width} meters."
    square_meters = area(length, width)
    square_feet = Float.round(square_meters / @conversion_factor, 3)
    IO.puts "The area is \n#{square_meters} square meters \n#{square_feet} square feet"
  end

  defp area(length, width), do: length * width
end

AreaRectangularRoom.run()
