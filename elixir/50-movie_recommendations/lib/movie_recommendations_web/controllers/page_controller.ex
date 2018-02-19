defmodule MovieRecommendationsWeb.PageController do
  use MovieRecommendationsWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
