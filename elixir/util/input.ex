defmodule Input do
  def string(prompt) do
    IO.gets(prompt) |> String.trim
  end

  def int(prompt) do
    IO.gets(prompt) |> Integer.parse |> validate_number
  end

  def int_p(prompt) do
    int(prompt) |> validate_positive
  end

  def float(prompt) do
    IO.gets(prompt) |> Float.parse |> validate_number
  end

  def float_p(prompt) do
    float(prompt) |> validate_positive
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
