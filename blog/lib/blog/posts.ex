defmodule Blog.Posts do
  @moduledoc """
  The Posts context.
  """

  import Ecto.Query, warn: false
  alias Blog.Repo

  alias Blog.Posts.Post
  alias Blog.Comments.Comment
  alias Blog.Tags.Tag
  alias Blog.PostTags.PostTag

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Post
    |> where([p], p.visibility)
    |> where([p], p.published_on <= ^DateTime.utc_now())
    |> order_by([p], desc: p.published_on)
    |> Repo.all()
  end

  @doc """
  Returns the list of posts when parameters is nil.

  ## Examples

      iex> list_posts(nil)
      [%Post{}, ...]

  """
  def list_posts(nil) do
    list_posts()
  end

  def list_posts(title) do
    Post
    |> where([p], ilike(p.title, ^"%#{title}%"))
    |> where([p], p.visibility)
    |> where([p], p.published_on <= ^DateTime.utc_now())
    |> order_by([p], desc: p.published_on)
    |> Repo.all()
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id) do
    comment_order_query = from(c in Comment, order_by: {:desc, c.updated_at})
    from(p in Post, preload: [:user, comments: ^comment_order_query])
    |> Repo.get!(id)
  end

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end

  def get_tags!(postId) do
    from(p in Post,
      join: pt in PostTag,
      on: pt.post_id == p.id,
      join: t in Tag,
      on: pt.tag_id == t.id,
      where: p.id == ^postId,
      select: t.name
    )
    |> Repo.all()
  end
end
