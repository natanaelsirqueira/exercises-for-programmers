defmodule TodoList.PageControllerTest do
  use TodoList.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "My TodoList"
  end
end
