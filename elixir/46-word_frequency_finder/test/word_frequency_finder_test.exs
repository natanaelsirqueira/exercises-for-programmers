defmodule WordFrequencyFinderTest do
  use ExUnit.Case

  alias WordFrequencyFinder

  test "calculates correctly the frequency of each word" do
    path = "test/assets/words.txt"
    assert WordFrequencyFinder.run(path) == [["badger", 7], ["mushroom", 2], ["snake", 1]]
  end
end
