defmodule GrabbingTheWeather do
  @moduledoc """
  Prompts for a city name and that returns the current temperature for the city.
  """

  use Tesla

  @appid Application.get_env(:grabbing_the_weather, :appid)

  plug(Tesla.Middleware.BaseUrl, "http://api.openweathermap.org/data/2.5")
  plug(Tesla.Middleware.JSON)

  @doc """
  Gets the weather data from the external API.

  ## Examples

      iex> response = GrabbingTheWeather.weather_in("London")
      iex> response.status
      200
  """
  def weather_in(city) do
    get("/weather?q=#{city}&appid=#{@appid}")
  end

  @doc """
  Returns information about the weather for the city passed as parameter.
  """
  def get_weather_for(city) do
    %{body: body} = weather_in(city)

    %{
      temp: body["main"]["temp"],
      humidity: body["main"]["humidity"],
      sunrise: body["sys"]["sunrise"],
      sunset: body["sys"]["sunset"],
      description: get_description(body["weather"]),
      wind: body["wind"]["deg"]
    }
  end

  def run do
    city = IO.gets("Where are you? ") |> String.trim()

    weather = get_weather_for(city)

    output = """
    #{city} weather:
    #{kelvin_to_fahrenheit(weather.temp)} degrees Fahrenheit
    #{kelvin_to_celsius(weather.temp)} degrees Celsius

    Other information:
    Sunrise time: #{format_unix_timestamp(weather.sunrise)}
    Sunset time: #{format_unix_timestamp(weather.sunset)}
    Humidity: #{weather.humidity}
    Description of the weather: #{weather.description}

    Wind direction: #{parse_wind_direction(weather.wind)}
    """

    IO.puts(output)
  end

  @doc """
  Converts the wind direction value in degrees to words.

  ## Examples

      iex> GrabbingTheWeather.parse_wind_direction(0)
      "North"
      iex> GrabbingTheWeather.parse_wind_direction(180)
      "South"
      iex> GrabbingTheWeather.parse_wind_direction(720)
      "North"
      iex> GrabbingTheWeather.parse_wind_direction(11)
      "North"
      iex> GrabbingTheWeather.parse_wind_direction(12)
      "North-NorthEast"
      iex> GrabbingTheWeather.parse_wind_direction(33)
      "North-NorthEast"
      iex> GrabbingTheWeather.parse_wind_direction(34)
      "North-East"
  """
  def parse_wind_direction(degrees) do
    val = trunc(degrees / 22.5 + 0.5)

    compass =
      {"North", "North-NorthEast", "North-East", "East-NorthEast", "East", "East-SouthEast",
       "South-East", "South-SouthEast", "South", "South-SouthWest", "South-West",
       "West-SouthWest", "West", "West-NorthWest", "North-West", "North-NorthWest"}

    elem(compass, rem(val, 16))
  end

  defp get_description(descriptions) do
    descriptions
    |> List.wrap()
    |> Enum.map(fn desc -> desc["description"] end)
    |> Enum.join(", ")
  end

  defp format_unix_timestamp(timestamp) do
    with {:ok, datetime} <- DateTime.from_unix(timestamp) do
      datetime |> DateTime.to_naive() |> to_string()
    end
  end

  defp kelvin_to_fahrenheit(temp), do: Float.round(temp * 9/5 - 459.67, 2)
  defp kelvin_to_celsius(temp), do: Float.round(temp - 273.15, 2)
end
