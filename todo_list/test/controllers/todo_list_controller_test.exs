defmodule TodoList.TodoListControllerTest do
  use TodoList.ConnCase, async: true

  describe "POST /" do
    test "does not accepts an empty description", %{conn: conn} do
      contents =
        post(conn, "/", %{"task" => %{"description" => ""}})
        |> html_response(200)

      assert String.contains?(contents, "You must enter a description!")
    end

    test "creates a task with valid description", %{conn: conn} do
      conn = post(conn, "/", %{"task" => %{"description" => "test"}})

      contents =
        conn
        |> get("/")
        |> html_response(200)

      import Phoenix.HTML
      should_contain = "Task 'test' created." |> html_escape |> safe_to_string
      assert String.contains?(contents, should_contain)
    end
  end

  describe "GET /" do
    test "shows a list of all tasks created", %{conn: conn} do
      Repo.insert(%TodoList.Task{description: "test task 1"})
      Repo.insert(%TodoList.Task{description: "test task 2"})
      contents =
        conn
        |> get("/")
        |> html_response(200)

      assert String.contains?(contents, "test task 1") &&
             String.contains?(contents, "test task 2")
    end

    test "removes a task, signifying it's been completed", %{conn: conn} do
      task = Repo.insert!(%TodoList.Task{description: "test task"})

      conn
      |> delete("/#{task.id}")
      |> html_response(302)

      assert Repo.all(TodoList.Task) == []
    end
  end
end
