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
    has_many :comments, Blog.Comments.Comment, on_delete: :delete_all
    belongs_to :user, Blog.Accounts.User, foreign_key: :created_user_id, references: :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :published_on, :visibility, :created_user_id])
    |> validate_required([:title, :content, :published_on, :visibility, :created_user_id])
    |> unique_constraint(:title, message: "This title is already recorded!")
  end
end
