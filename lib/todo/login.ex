defmodule Todo.Login do

  use Phauxth.Login.Base

  alias Todo.Auth

  @impl true
  # the authenticate function is overriden to check the user struct
  # to see if the user is confirmed.
  # if the user has not been confirmed, an error is returned

  def authenticate(%{"password" => password} = params, _, opts) do
    case Auth.get_by(params) do
      nil -> {:error, "no user found"}
      %{confirmed_at: nil} -> {:error, "account unconfirmed"}
      user -> Comeonin.Bcrypt.check_pass(user, password, opts)
    end
  end
end

