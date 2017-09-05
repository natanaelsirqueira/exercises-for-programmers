Code.load_file("../util/input.ex")

defmodule MagicEightBall do
  import Input

  def run do
    list = ["Yes", "No", "Maybe", "Ask again later"]

    string("What's your question? ")

    IO.puts("#{Enum.random(list)}.")
  end
end

MagicEightBall.run()
