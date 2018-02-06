defmodule GrabbingTheWeather do
  @moduledoc """
  Prompts for a city name and that returns the current temperature for the city.
  """

  use Tesla

  @appid Application.get_env(:grabbing_the_weather, :appid)

  plug(Tesla.Middleware.BaseUrl, "http://api.openweathermap.org/data/2.5")
  plug(Tesla.Middleware.JSON)

  @doc """


  ## Examples

      iex> response = GrabbingTheWeather.weather_in("London")
      iex> response.status
      200
  """
  def weather_in(city) do
    get("/weather?q=#{city}&appid=#{@appid}")
  end

  def get_weather_for(city) do
    %{body: body} = weather_in(city)
    |> IO.inspect

    %{
      temp: body["main"]["temp"],
      humidity: body["main"]["humidity"],
      sunrise: body["sys"]["sunrise"],
      sunset: body["sys"]["sunset"],
      description: body["weather"]["description"],
    }
  end

  def run do
    city = IO.gets("Where are you? ") |> String.trim()

    weather = get_weather_for(city)

    IO.puts("Chicago weather: ")
    IO.puts("#{weather.temp} degrees Fahrenheit")
  end
end
