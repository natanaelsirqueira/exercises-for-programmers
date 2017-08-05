Code.load_file("../util/input.ex")

defmodule CountingCharacters do
  import Input

  def run do
    str = string("What is the input string? ")
    len = String.length(str)
    IO.puts out(str, len)
  end

  def out(str, len) when len > 0 do
    "#{str} has #{len} characters"
  end

  def out(_str, _len) do
    "You must enter something."
  end
end

CountingCharacters.run()
