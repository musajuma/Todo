defmodule Todo.Auth do

  alias Todo.{User, Repo}

  def sign_in(email, password) do
    user = Repo.get_by(User, email: email)

    cond do
      user && Comeonin.Bcrypt.checkpw(password, user.encrypted_password) ->
        {:ok, user}
      true ->
        {:error, :unauthorized}
    end
  end

  def current_user(conn) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)
      if user_id, do: Repo.get(User, user_id)
  end

  def user_signed_in?(conn) do
    !!current_user(conn)
  end

  def register_user(params) do
    User.registration_changeset(%User{}, params) |> Repo.insert()
  end

  def get_user!(id), do: Repo.get(User, id)

  def get_by(%{"email" => email}) do
    Repo.get_by(User, email: email)
  end

  def gets_by(%{"user_id" => user_id}), do: Repo.get(User, user_id)

  def confirm_user(%User{} = user) do
    user |> User.confirm_changeset() |> Repo.update()
  end

  def sign_out(conn) do
    Plug.Conn.configure_session(conn, drop: true)
  end
end
