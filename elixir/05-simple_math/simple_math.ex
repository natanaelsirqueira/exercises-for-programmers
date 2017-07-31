Code.load_file("../util/input.ex")

defmodule SimpleMath do
  import Input

  def run do
    a = int_p("What is the first number? ")
    b = int_p("What is the second number? ")

    print_operations(a, b)
  end

  defp print_operations(a, b) do
    Enum.each(~w[+ - * /], fn o ->
      IO.puts "#{a} #{o} #{b} = #{result(o, a, b)}"
    end)
  end

  defp result(<< o::size(8) >>, a, b) do
    case o do
      ?+ -> a + b
      ?- -> a - b
      ?* -> a * b
      ?/ -> a / b
    end
  end
end

SimpleMath.run()
