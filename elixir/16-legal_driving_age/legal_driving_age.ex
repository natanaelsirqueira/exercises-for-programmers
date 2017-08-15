Code.load_file("../util/input.ex")

defmodule LegalDrivingAge do
  import Input

  def run do
    age = int_p("What is your age? ")

    legal_driving_countries =
      Enum.filter(list_countries(), fn
        {_abbr, driving_age} -> driving_age == age
      end)
      |> Enum.map(fn
        {abbr, _driving_age} -> to_string(abbr)
      end)
      |> Enum.reduce(fn(country, acc) ->
        "#{acc}, #{country}"
      end)

    IO.puts "You can drive legally in the countries: #{legal_driving_countries}"
  end

  defp list_countries do
    ["US": 15, "FR": 15, "SE": 16, "IT": 17, "UK": 17]
  end
end

LegalDrivingAge.run()
