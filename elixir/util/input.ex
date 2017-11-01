defmodule Input do
  @moduledoc """
  Helper functions for prompting values from the user.
  """

  @doc """
  Prompts for a string value.
  """
  def string(prompt) do
    read(prompt, validate_blank())
  end

  @doc """
  Prompts for an integer value.
  """
  def int(prompt) do
    read(prompt, parse_integer())
  end

  @doc """
  Prompts for a positive integer value.
  """
  def int_p(prompt) do
    read(prompt, validate_steps([parse_integer(), validate_min(1)]))
  end

  @doc """
  Prompts for a floating-point value.
  """
  def float(prompt) do
    read(prompt, parse_float())
  end

  @doc """
  Prompts for a positive floating-point value.
  """
  def float_p(prompt) do
    read(prompt, validate_steps([parse_float(), validate_min(1)]))
  end

  defp read(prompt, validator) do
    value = IO.gets(prompt)

    case validator.(value) do
      {:ok, value} -> value
      {:error, error} ->
        IO.puts(error)
        read(prompt, validator)
    end
  end

  defp validate_steps(steps), do: fn value -> run_steps(steps, value) end

  defp run_steps([], value), do: {:ok, value}

  defp run_steps([head | tail], value) do
    with {:ok, new_value} <- head.(value) do
      run_steps(tail, new_value)
    end
  end

  defp validate_blank do
    fn str ->
      case String.trim(str) do
        "" -> {:error, "You must enter something."}
        value -> {:ok, value}
      end
    end
  end

  defp parse_integer, do: fn n -> parse_number(n, &Integer.parse/1) end

  defp parse_float, do: fn n -> parse_number(n, &Float.parse/1) end

  defp parse_number(number, parser), do: parser.(number) |> check_parsing()

  defp check_parsing({x, _}), do: {:ok, x}
  defp check_parsing(:error), do: {:error, "You must provide a number."}

  defp validate_min(min) do
    fn n ->
      if n >= min do
        {:ok, n}
      else
        {:error, "You must provide a positive number."}
      end
    end
  end
end
