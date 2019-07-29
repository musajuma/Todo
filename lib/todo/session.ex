defmodule Todo.Session do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Todo.{User, Repo}

  @max_age 14_800

  @type t :: %__MODULE__{
    confirmed_at: DateTime.t(),
    id: integer,
    user_id: integer,
    user: User.t() | %Ecto.Association.NotLoaded{},
  }

  schema "sessions" do
    field :confirmed_at, :utc_datetime
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(session, attrs) do
    session
    |> set_confirmed_at(attrs)
    |> cast(attrs, [:user_id])
    |> validate_required([:user_id])
  end

  defp set_confirmed_at(%__MODULE__{} = session, attrs) do
    max_age = attrs[:max_age] || @max_age
    {:ok, expires_at} = exp_datetime(max_age)
    %__MODULE__{session | confirmed_at: DateTime.truncate(expires_at, :second)}
  end

  defp exp_datetime(max_age) do
    DateTime.utc_now()
    |> DateTime.to_naive()
    |> NaiveDateTime.add(max_age)
    |> DateTime.from_naive("Etc/UTC")
  end

  def create_session(attrs \\ %{}) do
    %__MODULE__{} |> changeset(attrs) |> Repo.insert()
  end

  def get_session(id) do
    now = DateTime.utc_now()
    Repo.get(from(s in __MODULE__, where: s.confirmed_at > ^now), id)
  end
end
