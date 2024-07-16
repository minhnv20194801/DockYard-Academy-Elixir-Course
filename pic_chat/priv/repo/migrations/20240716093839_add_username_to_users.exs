defmodule PicChat.Repo.Migrations.AddUsernameToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add(:username, :text, null: false)
    end
  end
end
