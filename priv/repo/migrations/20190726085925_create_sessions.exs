defmodule Todo.Repo.Migrations.CreateSessions do
  use Ecto.Migration

  def change do
    create table(:sessions) do
      add :confirmed_at, :utc_datetime
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    # create index(:sessions, [:user_id])
  end
end
