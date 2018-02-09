defmodule GrabbingTheWeatherTest do
  use ExUnit.Case
  doctest GrabbingTheWeather

  describe "get_weather_for/1" do
    setup do
      %{data: GrabbingTheWeather.get_weather_for("Chicago")}
    end

    test "returns the temperature for the city passed as parameter", %{data: data} do
      assert data.temp
    end

    test "returns the sunrise and sunset times, the humidity and a description of the weather", %{data: data} do
      expected_keys = ~w[sunrise sunset humidity description]a
      assert Enum.all?(expected_keys, &data[&1])
    end

    test "returns the wind direction", %{data: data} do
      assert data.wind
    end
  end
end
