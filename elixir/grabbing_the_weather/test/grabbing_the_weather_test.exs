defmodule GrabbingTheWeatherTest do
  use ExUnit.Case
  doctest GrabbingTheWeather

  describe "get_weather_for/1" do
    test "returns the temperature for the city passed as parameter" do
      assert %{temp: temp} = GrabbingTheWeather.get_weather_for("London")
      assert temp
    end

    test "returns the sunrise and sunset times, the humidity and a description of the weather." do
      expected_keys = ~w[sunrise sunset humidity description]a
      assert data = GrabbingTheWeather.get_weather_for("London")
      assert Enum.all?(expected_keys, &data[&1])
    end
  end
end
