defmodule Input do
  def int(text) do
    IO.gets(text) |> Integer.parse |> validate_number
  end

  def int_p(text) do
    int(text) |> validate_positive
  end

  def float(text) do
    IO.gets(text) |> Float.parse |> validate_number
  end

  def float_p(text) do
    float(text) |> validate_positive
  end

  def string(text) do
    IO.gets(text) |> String.trim
  end

  defp validate_number({x, _}) when is_number(x), do: x
  defp validate_number(:error) do
    error("You must enter a number.")
  end

  defp validate_positive(x) when x > 0, do: x
  defp validate_positive(_x) do
    error("You must enter a positive number.")
  end

  defp error(message) do
    IO.puts message
    System.halt(1)
  end
end
