defmodule MovieRecommendationsWeb.MovieSearchController do
  @moduledoc false

  use MovieRecommendationsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", action: :search)
  end

  def search(conn, %{"title" => ""}) do
    render(conn, "error.html", error: "Empty search.")
  end

  def search(conn, %{"title" => title, "first_result" => "true"}) do
    with {:ok, data} <- search_movie(title, true) do
      redirect(conn, to: "/movie-recommendations/movie/#{data["imdbID"]}")
    else
      {:error, reason} ->
        render(conn, "error.html", error: reason)
    end
  end

  def search(conn, %{"title" => title}) do
    with {:ok, results} <- search_movie(title, false) do
      render(conn, "results.html", %{results: results})
    else
      {:error, reason} ->
        render(conn, "error.html", error: reason)
    end
  end

  defp search_movie(title, first_result?) do
    key = if first_result?, do: "exact_match:#{title}", else: "title_match:#{title}"

    fetch_data(key, title, first_result?)
  end

  defp fetch_data(key, title, first_result?) do
    case Cachex.get(:movie_search, key) do
      {:ok, data} ->
        send(self(), {:cache_hit, key})
        {:ok, data}

      {:missing, nil} ->
        with {:ok, results} <- MovieRecommendations.search_movie(title) do
          value = if first_result?, do: List.first(results), else: results

          set_cache_key(key, value)

          {:ok, value}
        end
    end
  end

  defp set_cache_key(key, value) do
    ttl = Application.get_env(:movie_recommendations, :cache_key_ttl)

    {:ok, true} = Cachex.set(:movie_search, key, value)
    {:ok, true} = Cachex.expire(:movie_search, key, ttl)
  end
end
