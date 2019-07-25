defmodule Todo.Email do
  import Bamboo.Email

  alias TodoWeb.Mailer

  def welcome_email(user, key) do
    base_email(user)
    |> to(user)
    |> subject("Welcome to the app.")
    |> text_body("Confirm your email here http://localhost:4000/confirm?key=#{key}")
    |> Mailer.deliver_now()
  end

  def confirm_email(email) do
    base_email(email)
    |> subject("Account_confirmed")
    |> text_body("Your Account has been confirmed")
    |> Mailer.deliver_now()
  end

  defp base_email(email) do
    new_email(
      to: email,
      from: "admin@Todo.com"
    )
  end
end
