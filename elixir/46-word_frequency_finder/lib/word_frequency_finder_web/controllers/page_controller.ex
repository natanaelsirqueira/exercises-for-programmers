defmodule WordFrequencyFinderWeb.PageController do
  use WordFrequencyFinderWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
