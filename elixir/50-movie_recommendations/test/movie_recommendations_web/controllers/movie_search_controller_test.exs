defmodule MovieRecommendationsWeb.MovieSearchControllerTest do
  use MovieRecommendationsWeb.ConnCase

  describe "POST /movie-recommendations/search" do
    test "shows a list with the search results", %{conn: conn} do
      html =
        conn
        |> post("/movie-recommendations/search", %{"title" => "Blade Runner"})
        |> html_response(200)

      assert String.contains?(html, ["Blade Runner", "1982"])
      assert String.contains?(html, ["Blade Runner 2049", "2017"])
    end

    test "redirects to the first result page when required", %{conn: conn} do
      html =
        conn
        |> post("/movie-recommendations/search", %{"title" => "Blade Runner", "first_result" => "true"})
        |> html_response(302)

      assert String.contains?(html, "/movie-recommendations/movie/tt0083658")
    end

    test "shows an error message when nothing is provided", %{conn: conn} do
      html =
        conn
        |> post("/movie-recommendations/search", %{"title" => ""})
        |> html_response(200)

      assert String.contains?(html, "Empty search.")
    end
  end
end
