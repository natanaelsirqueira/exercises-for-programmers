defmodule MovieRecommendationsWeb.MovieController do
  use MovieRecommendationsWeb, :controller

  def index(conn, %{"imdbID" => imdb_id}) do
    with {:ok, data} <- MovieRecommendations.get_details(imdb_id) do
      render(conn, "index.html", movie: data)
    end
  end
end
