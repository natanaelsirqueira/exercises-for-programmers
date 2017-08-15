Code.load_file("../util/input.ex")

defmodule PasswordValidation do
  import Input

  def run do
    username = string("What is the username? ")
    password = string("What is the password? ")

    user_ok =
      Enum.any?(users(), fn (%{name: name, pass: pass}) ->
        ((name == username) && (pass == password))
      end)

    IO.puts out(user_ok)
  end

  defp out(true), do: "Welcome!"
  defp out(false), do: "I don't know you."

  defp users do
    [
      %{name: "max", pass: "rewind"}, %{name: "chloe", pass: "badass"},
      %{name: "warren", pass: "science"}, %{name: "nathan", pass: "asshole"}
    ]
  end
end

PasswordValidation.run()
