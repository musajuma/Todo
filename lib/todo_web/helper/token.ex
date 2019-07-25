defmodule TodoWeb.Helper.Token do
  @behaviour Phauxth.Token

  alias Phoenix.Token
  alias TodoWeb.Endpoint

  @max_age 14_400
  @token_salt "ZT1mqttq"

  @impl true
  def sign(data, opts \\ []) do
    Token.sign(Endpoint, @token_salt, data, opts)
  end

  @impl true
  def verify(token, opts \\ []) do
    Token.verify(Endpoint, @token_salt, token, opts ++ [max_age: @max_age])
  end
end
