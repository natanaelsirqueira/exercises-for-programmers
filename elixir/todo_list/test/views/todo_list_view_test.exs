defmodule TodoList.TodoListViewTest do
  use TodoList.ConnCase, async: true
  import Phoenix.View

  test "renders index.html", %{conn: conn} do
    tasks = [%TodoList.Task{id: 1, description: "learn phoenx"},
             %TodoList.Task{id: 2, description: "build an app"}]
    changeset = TodoList.Task.changeset(%TodoList.Task{})
    content = render_to_string(TodoList.TodoListView, "index.html",
                    conn: conn, changeset: changeset, tasks: tasks)

    assert String.contains?(content, "My TodoList")
    for task <- tasks do
      assert String.contains?(content, task.description)
    end
  end
end
