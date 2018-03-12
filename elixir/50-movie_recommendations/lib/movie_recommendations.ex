defmodule MovieRecommendations do
  @moduledoc """
  Context that manages the search and the data provided by the external API.
  """

  use Tesla

  plug(Tesla.Middleware.BaseUrl, "http://www.omdbapi.com")
  plug(Tesla.Middleware.JSON)

  @api_key Application.get_env(:movie_recommendations, :api_key)

  @tmdb_base_url "http://api.themoviedb.org/3/movie"
  @tmdb_api_key Application.get_env(:tmdb, :api_key)

  @doc """
  Returns the search results.

  ## Examples

      iex> response = MovieRecommendations.movie("Fight Club")
      iex> response.status
      200
      iex> is_list(response.body["Search"])
      true
  """
  def movie(title) do
    title = String.replace(title, " ", "+")

    get("/?s=#{title}&apikey=#{@api_key}")
  end

  @doc """
  Returns the details of the movie.

  ## Examples

      iex> response = MovieRecommendations.movie("Fight Club")
      iex> response.status
      200
  """
  def details(imdb_id) do
    get("/?i=#{imdb_id}&apikey=#{@api_key}")
  end

  @doc """
  Returns the movie trailer.

  ## Examples

      iex> response = MovieRecommendations.trailer("tt0137523")
      iex> [trailer | _] = response.body["results"]
      iex> trailer["type"]
      "Trailer"
  """
  def trailer(imdb_id) do
    get("#{@tmdb_base_url}/#{imdb_id}/videos?api_key=#{@tmdb_api_key}")
  end

  @doc """
  Returns a list of search results.

  ## Examples

      iex> {:ok, [first_result | _]} = MovieRecommendations.search_movie("Fight Club")
      iex> first_result["Title"]
      "Fight Club"
  """
  def search_movie(title) do
    with %Tesla.Env{status: 200, body: %{"Search" => results}} <- movie(title) do
      results = Enum.filter(results, &(&1["Type"] == "movie"))

      {:ok, results}
    else
      %Tesla.Env{status: 200, body: %{"Error" => reason}} ->
        {:error, reason}
    end
  end

  @doc """
  Returns all the details of the movie.

  ## Examples

      iex> {:ok, data} = MovieRecommendations.get_details("tt0137523")
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
    with %Tesla.Env{body: data} <- details(imdb_id) do
      ratings =
        data["Ratings"]
        |> Stream.map(fn rating -> {rating["Source"], rating["Value"]} end)
        |> Stream.map(&parse_rating/1)

      recommendation =
        ratings
        |> Enum.reduce(0, fn [_source, value], sum -> value + sum end)
        |> Kernel./(3)
        |> get_recommendation()

      data =
        data
        |> Map.put("Trailer", find_trailer(imdb_id))
        |> Map.put("Ratings", ratings)
        |> Map.put("Recomendation", recommendation)
        |> Map.update!("Writer", &String.split(&1, ", "))
        |> Map.update!("Actors", &String.split(&1, ", "))

      {:ok, data}
    else
      %Tesla.Env{status: 200, body: %{"Error" => reason}} ->
        {:error, reason}
    end
  end

  defp find_trailer(imdb_id) do
    with %Tesla.Env{status: 200, body: %{"results" => results}} <- trailer(imdb_id) do
      [trailer | _] = Enum.filter(results, &(&1["type"] == "Trailer"))

      trailer
    else
      %Tesla.Env{status: 200, body: %{"Error" => reason}} ->
        {:error, reason}
    end
  end

  defp parse_rating({"Internet Movie Database" = source, value}) do
    [source, value |> String.split("/") |> List.first() |> String.to_float() |> Kernel.*(10)]
  end

  defp parse_rating({"Rotten Tomatoes" = source, value}) do
    [source, value |> String.replace("%", "") |> String.to_integer()]
  end

  defp parse_rating({"Metacritic" = source, value}) do
    [source, value |> String.split("/") |> List.first() |> String.to_integer()]
  end

  defp get_recommendation(average_rating) when average_rating >= 75,
    do: "You should watch this movie right now!"

  defp get_recommendation(average_rating) when average_rating < 60,
    do: "You should avoid this movie at all costs!"

  defp get_recommendation(_average_rating), do: "This movie is okay."
end
