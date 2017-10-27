defmodule WebsiteGeneratorWeb.PageController do
  use WebsiteGeneratorWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
