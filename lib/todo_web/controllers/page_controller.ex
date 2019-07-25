defmodule TodoWeb.PageController do
  use TodoWeb, :controller

  alias Todo.TodoList
  def index(conn, _params) do
    todo = TodoList.list_todo()
    render(conn, "index.html", todo: todo)
  end
end
