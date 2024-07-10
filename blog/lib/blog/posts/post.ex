defmodule Blog.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "posts" do
    field :title, :string
    field :content, :string
    field :published_on, :date
    field :visibility, :boolean, default: false
    field :created_user_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :published_on, :visibility, :created_user_id])
    |> validate_required([:title, :content, :published_on, :visibility, :created_user_id])
  end
end
