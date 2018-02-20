defmodule MovieRecommendationsWeb.MovieSearchControllerTest do
  use MovieRecommendationsWeb.ConnCase

  describe "POST /movie-recommendations/search" do
    test "shows a list with the search results", %{conn: conn} do
      html = search_movie(conn, "Blade Runner", false)

      assert String.contains?(html, ["Blade Runner", "1982"])
      assert String.contains?(html, ["Blade Runner 2049", "2017"])
    end

    test "redirects directly to the first result page when required", %{conn: conn} do
      html = search_movie(conn, "Blade Runner", true)

      assert String.contains?(html, ["redirected", "/movie-recommendations/movie/tt0083658"])
    end

    test "shows an error message when nothing is provided", %{conn: conn} do
      html = search_movie(conn, "", false)

      assert String.contains?(html, "Empty search.")
    end
  end

  describe "cache support" do
    test "caches the movie data and hit it when available", %{conn: conn} do
      movie_title = "Fight Club"

      assert search_movie(conn, movie_title, true)
      assert {:ok, %{"Title" => ^movie_title}} =
        Cachex.get(:movie_search, "exact_match:#{movie_title}")

      assert search_movie(conn, movie_title, true)
      assert_receive {:cache_hit, "exact_match:Fight Club"}

      assert search_movie(conn, movie_title, false)
      assert {:ok, [%{"Title" => ^movie_title} | _]} =
        Cachex.get(:movie_search, "title_match:#{movie_title}")

      assert search_movie(conn, movie_title, false)
      assert_receive {:cache_hit, "title_match:Fight Club"}
    end

    test "automatically sets an expiration time for each key", %{conn: conn} do
      movie_title = "Fight Club"

      assert search_movie(conn, movie_title, true)
      assert {:ok, %{"Title" => ^movie_title}} =
        Cachex.get(:movie_search, "exact_match:#{movie_title}")

      Process.sleep(500)

      assert {:missing, nil} =  Cachex.get(:movie_search, "exact_match:#{movie_title}")
    end
  end

  defp search_movie(conn, title, true) do
    conn
    |> post("/movie-recommendations/search", %{"title" => title, "first_result" => "true"})
    |> html_response(302)
  end

  defp search_movie(conn, title, false) do
    conn
    |> post("/movie-recommendations/search", %{"title" => title})
    |> html_response(200)
  end
end
