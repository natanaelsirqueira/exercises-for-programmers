defmodule WebsiteGeneratorWeb.PageControllerTest do
  use WebsiteGeneratorWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to WebsiteGenerator!"
  end
end
