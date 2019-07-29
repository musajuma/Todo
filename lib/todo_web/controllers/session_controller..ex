defmodule TodoWeb.SessionController do
  use TodoWeb, :controller

  alias Todo.{Login, Auth, Email}
  alias Phauxth.Confirm

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => params}) do
    case Login.verify(params) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> put_flash(:info, "sign in successfull")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Account unconfirmed!. Check email for confirmation link ")
        |> render("new.html")
    end
  end

  def confirm(conn, params) do
    case Confirm.verify(params) do
      {:ok, user} ->
        Auth.confirm_user(user)
        Email.confirm_email(user.email)

        conn
        |> put_flash(:info, "Your account has been confirmed!, you can now sign in")
        |> render("new.html")

      {:error, message} ->
        conn
        |> put_flash(:error, message)
        |> render("new.html")
    end
  end


  def delete(conn, _params) do
    conn
    |> Auth.sign_out()
    |> redirect(to: Routes.page_path(conn, :index))
  end

end
