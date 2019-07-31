defmodule Todo.ItemList do

  alias Todo.{Todo, Item, Repo}

  def create_item(%Todo{} = todo, attrs \\  %{}) do
    todo
      |> Ecto.build_assoc(:items)
      |> Item.changeset(attrs)
      |> Repo.insert()
  end

  def change_item(%Item{} = item) do
    Item.changeset(item, %{})
  end
end
