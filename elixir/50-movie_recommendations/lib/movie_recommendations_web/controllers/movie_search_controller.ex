defmodule MovieRecommendationsWeb.MovieSearchController do
  use MovieRecommendationsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", action: :search)
  end

  def search(conn, %{"title" => ""}) do
    render(conn, "error.html", error: "Empty search.")
  end

  def search(conn, %{"title" => title, "first_result" => "true"}) do
    with {:ok, [first_result | _]} <- MovieRecommendations.search_movie(title) do
      redirect(conn, to: "/movie-recommendations/movie/#{first_result["imdbID"]}")
    else
      {:error, reason} ->
        render(conn, "error.html", error: reason)
    end
  end

  def search(conn, %{"title" => title}) do
    with {:ok, results} <- MovieRecommendations.search_movie(title) do
      render(conn, "results.html", %{results: results})
    else
      {:error, reason} ->
        render(conn, "error.html", error: reason)
    end
  end

  defp render_index_with(conn, changeset) do
    render(conn, "index.html", changeset: changeset, action: :search)
  end
end
