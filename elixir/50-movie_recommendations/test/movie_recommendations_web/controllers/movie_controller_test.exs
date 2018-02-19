defmodule MovieRecommendationsWeb.MovieControllerTest do
  use MovieRecommendationsWeb.ConnCase

  describe "POST /movie-recommendations/movie/:imdbID" do
    test "returns a list with the search results", %{conn: conn} do
      content =
        conn
        |> get("/movie-recommendations/movie/tt0137523")
        |> html_response(200)

      assert String.contains?(content, ["Fight Club", "1999", "David Fincher", "Brad Pitt"])
    end
  end
end
