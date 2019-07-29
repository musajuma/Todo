defmodule TodoWeb.TodoController do
  use TodoWeb, :controller

  alias Todo.{TodoList, Todo, Repo}

  plug TodoWeb.Plugs.AuthenticateUser when action not in [:index]

  def new(conn, _params) do
    changeset = TodoList.change_todo(%Todo{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"todo" => todo_params}) do
    case TodoList.create_todo(todo_params) do
      {:ok, _todo} ->
        conn

        |> put_flash(:info, "Todo topic created")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def show(conn, info) do
    todoinfo = Repo.get(Todo, info["id"])
    render conn, "show.html", todo: todoinfo
  end

  def edit(conn, %{"id" => id}) do
    todo = TodoList.get_todo!(id)
    changeset = TodoList.change_todo(todo)
    render conn, "edit.html", todo: todo, changeset: changeset
  end

  def update(conn, %{"id" => id, "todo" => todo_params}) do
    todo = TodoList.get_todo!(id)

    case TodoList.update_todo(todo, todo_params) do
      {:ok, todo} ->
        conn
        |> put_flash(:info, "Todo updated")
        |> redirect(to: Routes.todo_path(conn, :show, todo))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", todo: todo, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo = TodoList.get_todo!(id)
    {:ok, _todo} = TodoList.delete_todo(todo)

    conn
    |> put_flash(:info, "Todo deleted.")
    |> redirect(to: Routes.page_path(conn, :index))
  end

end
