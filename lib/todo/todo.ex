defmodule Todo.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  alias Todo.{User, Item}

  schema "todos" do
    field :title, :string
    belongs_to :user, User
    has_many :items, Item

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
