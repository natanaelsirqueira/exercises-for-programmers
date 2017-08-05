Code.load_file("../util/input.ex")

defmodule Quote do
  import Input

  def run do
    quote = string("What is the quote? ")
    author = string("Who said it? ")
    print(quote, author)
  end

  def print(quote, author) do
    IO.puts "#{author} says, \"#{quote}\""
  end

  def print_list(quotes) do
    Enum.each(quotes, fn elem -> print(elem.quote, elem.author) end)
  end
end

Quote.print_list(
  [%{quote: "These aren't the droids you're looking for.", author: "Obi-Wan Kenobi"},
   %{quote: "I find your lack of faith disturbing.",       author: "Darth Vader"},
   %{quote: "Do. Or do not. There is no try.",             author: "Yoda"}])
