defmodule TodoWeb.ItemController do
  use TodoWeb, :controller

  alias Todo.{TodoList, ItemList}

  def create(conn, %{"todo_id" => todo_id, "item" => item_params}) do
    todo = TodoList.get_todo!(todo_id)

    case ItemList.create_item(todo, item_params) do
      {:ok, _item} ->
        conn

        |> put_flash(:info, "Item created")
        |> redirect(to: Routes.todo_path(conn, :show, todo))

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Issue creating the item")
        |> redirect(to: Routes.todo_path(conn, :show, todo))
    end
  end
end
