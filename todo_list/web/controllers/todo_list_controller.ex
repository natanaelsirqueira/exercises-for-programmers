defmodule TodoList.TodoListController do
  use TodoList.Web, :controller
  alias TodoList.Task

  def index(conn, _params) do
    tasks = Repo.all(TodoList.Task)
    changeset = Task.changeset(%Task{})
    render(conn, "index.html", tasks: tasks, changeset: changeset)
  end

  def create(conn, %{"task" => description}) do
    changeset = Task.changeset(%Task{}, description)
    case Repo.insert(changeset) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task '#{task.description}' created.")
        |> redirect(to: todo_list_path(conn, :index))
      {:error, changeset} ->
        index(conn, changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Repo.get!(TodoList.Task, id)

    Repo.delete!(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: todo_list_path(conn, :index))
  end
end
