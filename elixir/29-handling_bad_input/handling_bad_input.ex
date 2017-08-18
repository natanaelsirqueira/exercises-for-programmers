defmodule HandlingBadInput do
  def run do
    rate = read("What is the rate of return? ")

    years = div(72, rate)

    IO.puts "It will take #{years} years to double your initial investment."
  end

  def read(text) do
    r = text |> IO.gets |> Integer.parse |> validate_input

    if is_number(r),
       do: r,
       else: IO.puts(r)
             read(text)
  end

  defp validate_input({x, _}), do: validate_number(x)
  defp validate_input(:error), do: "Sorry. That's not a valid input."

  defp validate_number(x) when x > 0, do: x
  defp validate_number(_), do: "The value 0 is not valid."
end

HandlingBadInput.run()
