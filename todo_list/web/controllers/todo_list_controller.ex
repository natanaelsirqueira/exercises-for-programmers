defmodule TodoList.TodoListController do
  use TodoList.Web, :controller

  def index(conn, _params) do
    tasks = Repo.all(TodoList.Task)
    render conn, "index.html", tasks: tasks
  end

  def done(conn, %{"task" => id}) do
    task = Repo.get!(TodoList.Task, id)

    Repo.delete!(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: todo_list_path(conn, :index))
  end
end
