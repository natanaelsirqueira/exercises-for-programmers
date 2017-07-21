defmodule TodoList.Repo.Migrations.CreateTask do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :description, :string, null: false

      timestamps()
    end
  end
end
