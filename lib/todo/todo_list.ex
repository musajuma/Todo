defmodule Todo.TodoList do

  alias Todo.{Repo, Todo}

  def create_todo(params) do
    Todo.changeset(%Todo{}, params)
    |> Repo.insert()
  end

  # def create_todo(user, attrs \\ %{}) do
  #   user
  #   |> Ecto.build_assoc(:todos)
  #   |> Todo.changeset(attrs)
  #   |> Repo.insert()
  # end

  def get_todo!(id), do: Repo.get!(Todo, id)

  def list_todo do
    Repo.all(Todo)
  end

  def change_todo(%Todo{} = todo) do
    Todo.changeset(todo, %{})
  end

  def update_todo(%Todo{} = todo, attrs) do
    todo
    |> Todo.changeset(attrs)
    |> Repo.update()
  end

  def delete_todo(%Todo{} = todo) do
    Repo.delete(todo)
  end
  def get_by(_attrs) do
  end

end
