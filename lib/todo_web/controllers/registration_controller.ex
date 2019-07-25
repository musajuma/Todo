defmodule TodoWeb.RegistrationController do
  use TodoWeb, :controller

    alias Todo.{Auth, Email}
    alias TodoWeb.Helper.Token
    alias Phauxth.Log

    def new(conn, _params) do
        render conn, "new.html", changeset: conn
    end

    def create(conn, %{"registration" => %{"email" => email} = registration_params}) do
        case Auth.register(registration_params) do
            {:ok, user} ->

                Log.info(%Log{user: user.id, message: "user created"})
                key = Token.sign(%{"email" => email})
                Email.welcome_email(email, key)

                conn
                |> put_session(:current_user_id, user.id)
                |> put_flash(:info, "You have successfully signed up!")
                |> redirect(to: Routes.session_path(conn, :new))

            {:error, changeset} ->
            render(conn, "new.html", changeset: changeset)
        end
    end
end
