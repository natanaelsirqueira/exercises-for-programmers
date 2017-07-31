Code.load_file("../util/input.ex")

defmodule PaintCalculator do
  import Input

  @conversion_rate 350

  def run do
    room_form = string("What is the form of the room? ")

    area =
      case room_form do
        "square" -> square_room()
        "round" -> round_room()
        "l_shaped" -> l_shaped_room()
      end

    gallons =
      area / @conversion_rate
      |> Float.ceil
      |> round

    IO.puts "\nYou will need to purchase #{gallons} #{gallons_out(gallons)} of" <>
            "\npaint to cover #{area} square feet."
  end

  defp gallons_out(1), do: "gallon"
  defp gallons_out(_), do: "gallons"

  defp square_room do
    length = float_p("What is the length of the ceiling? ")
    width = float_p("What is the width of the ceiling? ")

    length * width
  end

  defp round_room do
    radius = float_p("What is the radius of the ceiling? ")

    Float.round(:math.pi * :math.pow(radius, 2), 3)
  end

  defp l_shaped_room do
    IO.puts "First square information: "
    first = square_room()

    IO.puts "Second square information: "
    second = square_room()

    first + second
  end
end

PaintCalculator.run()
