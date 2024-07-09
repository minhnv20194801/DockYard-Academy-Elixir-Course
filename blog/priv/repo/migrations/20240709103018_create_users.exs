defmodule Blog.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :username, :string
      add :email, :string
      add :password, :string
      add :hashed_password, :string
      add :confirmed_at, :naive_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
