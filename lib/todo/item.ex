defmodule Todo.Item do
  use Ecto.Schema
  import Ecto.Changeset

  alias Todo.{User, Todo}

  schema "items" do
    field :item_name, :string
    belongs_to :todo, Todo
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:item_name])
    |> validate_required([:item_name])
  end
end
