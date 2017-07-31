Code.load_file("../util/input.ex")

defmodule RetirementCalculator do
  import Input

  def run do
    age = int_p("What is your current age? ")
    retirement_age = int_p("What age would you like to retire? ")

    print_result(retirement_age - age)
  end

  defp print_result(time_ultil_retire) when time_ultil_retire > 0 do
    current_year = Date.utc_today.year
    IO.puts "You have #{time_ultil_retire} years left until you can retire.\n" <>
            "It's #{current_year}, so you can retire in #{current_year + time_ultil_retire}"
  end

  defp print_result(_time_ultil_retire), do: IO.puts "You can already retire."
end

RetirementCalculator.run()
