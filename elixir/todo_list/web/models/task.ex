defmodule TodoList.Task do
  use TodoList.Web, :model

  schema "tasks" do
    field :description, :string

    timestamps()
  end

  def changeset(task, params \\ %{}) do
    task
    |> cast(params, [:description])
    |> validate_required([:description])
  end
end
