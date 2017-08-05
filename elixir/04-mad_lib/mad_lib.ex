Code.load_file("../util/input.ex")

defmodule MadLib do
  import Input

  def run do
    noun = string("Enter a noun: ")
    verb = string("Enter a verb: ")
    adjective = string("Enter an adjective: ")
    adverb = string("Enter an adverb: ")

    print(noun, verb, adjective, adverb)
  end

  def print(noun, verb, adjective, adverb) do
    IO.puts("Do you #{verb} with your #{adjective} #{noun} #{adverb}? That's hilarious!")
  end

  # TODO implement a branching story, where the answers to questions determine
  # how the story is constructed. (Hint: use Structs to build the branchs)

end

MadLib.run()
