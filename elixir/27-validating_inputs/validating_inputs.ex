Code.load_file("../util/input.ex")

defmodule ValidateInput do
  import Input

  def run() do
    first_name = string("Enter the first name: ")
    last_name = string("Enter the last name: ")
    zip_code = string("Enter the ZIP code: ")
    employee_ID = string("Enter an employee ID: ")

    form = validate_input(first_name, last_name, zip_code, employee_ID)

    if form.valid do
      IO.puts "There were no errors found."
    else
      IO.puts form.errors |> Enum.reverse |> Enum.join("\n")
      run()
    end
  end

  defp validate_input(first_name, last_name, zip_code, employee_ID) do
    form = %{valid: true,
             errors: [],
             data: %{first_name: first_name, last_name: last_name,
                     zip_code: zip_code, employee_ID: employee_ID}}

    form
    |> validate_required([:first_name, :last_name])
    |> validate_length([:first_name, :last_name])
    |> validate_format(:employee_ID, ~r/[A-Z]{2}\-\d{4}/, "#{employee_ID} is not a valid ID.")
    |> validate_format(:zip_code, ~r/\d+/, "The ZIP code must be numeric.")
  end

  defp validate_required(form, fields) do
    Enum.reduce(fields, form, fn(field, form) ->
      name = field |> to_string |> String.replace("_", " ")
      value = form.data[field]
      if value != "" do
        form
      else
        add_error(form, "The #{name} must be filled in.")
      end
    end)
  end

  defp validate_length(form, fields) do
    Enum.reduce(fields, form, fn(field, form) ->
      name = field |> to_string |> String.replace("_", " ")
      value = form.data[field]
      if value == "" or String.length(value) >= 2 do
        form
      else
        add_error(form, ~s|"#{value}" is not a valid #{name}. It is too short.|)
      end
    end)
  end

  defp validate_format(form, field, regex, error) do
    if String.match?(form.data[field], regex) do
      form
    else
      add_error(form, error)
    end
  end

  defp add_error(form, error) do
    form
    |> Map.put(:valid, false)
    |> Map.update!(:errors, fn errors ->
      [error | errors]
    end)
  end
end

ValidateInput.run()
