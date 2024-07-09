defmodule Blog.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :username, :string
    field :password, :string
    field :email, :string
    field :hashed_password, :string
    field :confirmed_at, :naive_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :hashed_password, :confirmed_at])
    |> validate_required([:username, :email, :password, :hashed_password, :confirmed_at])
  end
end
