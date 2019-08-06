defmodule Todo.Login do

  use Phauxth.Login.Base

  alias Todo.Auth


  def authenticate(%{"password" => password} = params, _, opts) do
    case Auth.get_by(params) do
      nil -> {:error, "no user found"}
      %{confirmed_at: nil} -> {:error, "account unconfirmed"}
      user -> Comeonin.Bcrypt.check_pass(user, password, opts)
    end
  end
end

