defmodule TodoList.TodoListController do
  use TodoList.Web, :controller
  alias TodoList.Task

  def index(conn, _params) do
    render_index_with(conn, Task.changeset(%Task{}))
  end

  def create(conn, %{"task" => task_params}) do
    changeset = Task.changeset(%Task{}, task_params)
    case Repo.insert(changeset) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task '#{task.description}' created.")
        |> redirect(to: todo_list_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "You must enter a description!")
        |> render_index_with(changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Repo.get!(TodoList.Task, id)

    Repo.delete!(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: todo_list_path(conn, :index))
  end

  defp render_index_with(conn, changeset) do
    tasks = Repo.all(TodoList.Task)
    render(conn, "index.html", tasks: tasks, changeset: changeset)
  end
end
