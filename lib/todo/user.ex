defmodule Todo.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    has_many :todos, Todo.Todo

    timestamps()
  end

  @doc false
  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:email], [])
    |> validate_required([:email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end

  def registration_changeset(user, attrs) do
    user
    |> changeset(attrs)
    |> cast(attrs, [:password], [])
    |> validate_required([:password])
    |> validate_length(:password, min: 6, max: 15)
    |> password_hash()
  end

  def confirm_changeset(user) do
    change(user, %{confirmed_at: DateTime.utc_now() |> DateTime.truncate(:second)})
  end

  defp password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end
end
