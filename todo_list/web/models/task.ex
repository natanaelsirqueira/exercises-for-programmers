defmodule TodoList.Task do
  use TodoList.Web, :model

  schema "tasks" do
    field :description, :string

    timestamps()
  end
end
