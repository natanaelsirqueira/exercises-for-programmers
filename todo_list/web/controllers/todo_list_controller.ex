defmodule TodoListController do
  use TodoList.Web, :controller

  def list(conn, _params) do
    render conn, "list.html"
  end
end
