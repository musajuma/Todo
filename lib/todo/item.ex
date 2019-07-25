defmodule Todo.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :item_name, :string
    belongs_to :todos, Todo.Todo
    belongs_to :user, Todo.User

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:item_name])
    |> validate_required([:item_name])
  end
end
