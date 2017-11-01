defmodule Input do
  @moduledoc """
  Helper functions for prompting values from the user.
  """

  @doc """
  Prompts for a string value.
  """
  def string(prompt, opts \\ []) do
    read(prompt, ExValidator.string([{:required, true} | opts]))
  end

  @doc """
  Prompts for an integer value.
  """
  def integer(prompt, opts \\ []) do
    read(prompt, number_validator(integer_validator(), opts))
  end

  @doc """
  Prompts for a floating-point value.
  """
  def float(prompt, opts \\ []) do
    read(prompt, number_validator(float_validator(), opts))
  end

  defp read(prompt, validator) do
    value = IO.gets(prompt)

    case validator.(value) do
      {:ok, value} -> value
      {:error, error} ->
        IO.puts("Error: Input #{error}.")
        read(prompt, validator)
    end
  end

  defp number_validator(type_validator, opts) do
    if opts[:positive] do
      positive_validator(type_validator)
    else
      type_validator
    end
  end

  defp integer_validator, do: ExValidator.integer(required: true, message: "is not an integer value")

  defp float_validator, do: ExValidator.float(required: true)

  defp positive_validator(type_validator) do
    ExValidator.compose([
      type_validator,
      & if(&1 > 0, do: {:ok, &1}, else: {:error, "is negative"})
    ])
  end
end
