defmodule MovieRecomendations do
  @moduledoc """
  Gets information about a given movie from an external API and recomends it
  based on its average rating across IMDb, Rotten Tomatoes and Metacritic.
  """

  use Tesla

  plug(Tesla.Middleware.BaseUrl, "http://www.omdbapi.com")
  plug(Tesla.Middleware.JSON)

  @api_key Application.get_env(:movie_recomendations, :api_key)

  @doc """
  Returns the search results.

  ## Examples

      iex> response = MovieRecomendations.movie("Fight Club")
      iex> response.status
      200
      iex> length(response.body["Search"]) > 0
      true
  """
  def movie(title) do
    title = String.replace(title, " ", "+")

    get("/?s=#{title}&apikey=#{@api_key}")
  end

  @doc """
  Returns the details of the movie.

  ## Examples

      iex> response = MovieRecomendations.movie("Fight Club")
      iex> response.status
      200
  """
  def details(imdb_id) do
    get("/?i=#{imdb_id}&apikey=#{@api_key}")
  end

  @doc """
  Returns the title, year and imdbID of the movie.

  ## Examples

      iex> MovieRecomendations.search_movie("Fight Club")
      %{title: "Fight Club", year: "1999", imdbID: "tt0137523"}
  """
  def search_movie(title) do
    %Tesla.Env{body: %{"Search" => [movie | _]}} = movie(title)

    %{
      title: movie["Title"],
      year: movie["Year"],
      imdbID: movie["imdbID"]
    }
  end

  @doc """
  Returns all the details of the movie.

  ## Examples

      iex> data = MovieRecomendations.get_details("tt0137523")
      iex> data["Title"]
      "Fight Club"
      iex> data["Year"]
      "1999"
      iex> data["Rated"]
      "R"
      iex> data["Runtime"]
      "139 min"
      iex> is_nil(data["Plot"])
      false
  """
  def get_details(imdb_id) do
    %Tesla.Env{body: data} = details(imdb_id)

    data
  end

  @doc """
  Returns a recomendation for the user based on the average rating of the movie
  across IMDb, Rotten Tomatoes and Metacritic.

  ## Examples

      iex> data = MovieRecomendations.result("Fight Club")
      iex> data["Recomendation"]
      "You should watch this movie right now!"
      iex> data = MovieRecomendations.result("Panic Room")
      iex> data["Recomendation"]
      "This movie is okay."
      iex> data = MovieRecomendations.result("Alien 3")
      iex> data["Recomendation"]
      "You should avoid this movie at all costs!"
  """
  def result(title) do
    %{imdbID: imdbID} = search_movie(title)
    data = get_details(imdbID)

    ratings =
      data["Ratings"]
      |> Stream.map(fn rating -> {rating["Source"], rating["Value"]} end)
      |> Stream.map(&parse_rating/1)

    average_rating = Enum.sum(ratings) / 3

    Map.put(data, "Recomendation", get_recomendation(average_rating))
  end

  def run do
    IO.gets("Enter the name of the movie: ")
    |> String.trim()
    |> result()
    |> show()
  end

  defp parse_rating({"Internet Movie Database", value}) do
    value |> String.split("/") |> List.first() |> String.to_float() |> Kernel.*(10)
  end

  defp parse_rating({"Rotten Tomatoes", value}) do
    value |> String.replace("%", "") |> String.to_integer()
  end

  defp parse_rating({"Metacritic", value}) do
    value |> String.split("/") |> List.first() |> String.to_integer()
  end

  defp get_recomendation(average_rating) when average_rating >= 75,
    do: "You should watch this movie right now!"

  defp get_recomendation(average_rating) when average_rating < 60,
    do: "You should avoid this movie at all costs!"

  defp get_recomendation(_average_rating), do: "This movie is okay."

  defp show(data) do
    IO.puts("""
    Title: #{data["Title"]}
    Year: #{data["Year"]}
    Rating: #{data["Rated"]}
    Running Time: #{data["Runtime"]}

    Description: #{data["Plot"]}

    #{data["Recomendation"]}
    """)
  end
end
