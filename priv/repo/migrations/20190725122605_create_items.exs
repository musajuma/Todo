defmodule Todo.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :item_name, :string
      add :todo_id, references(:todos, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:items, [:todo_id])
    create index(:items, [:user_id])
  end
end
