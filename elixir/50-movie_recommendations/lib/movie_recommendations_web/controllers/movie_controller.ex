defmodule MovieRecommendationsWeb.MovieController do
  @moduledoc false

  use MovieRecommendationsWeb, :controller

  def index(conn, %{"imdbID" => imdb_id}) do
    case Cachex.get(:movie_search, imdb_id) do
      {:ok, data} ->
        render(conn, "index.html", movie: data)

      {:missing, nil} ->
        with {:ok, data} <- MovieRecommendations.get_details(imdb_id) do
          ttl = Application.get_env(:movie_recommendations, :cache_key_ttl)

          {:ok, true} = Cachex.set(:movie_search, imdb_id, data)
          {:ok, true} = Cachex.expire(:movie_search, imdb_id, ttl)

          render(conn, "index.html", movie: data)
        end
    end
  end
end
