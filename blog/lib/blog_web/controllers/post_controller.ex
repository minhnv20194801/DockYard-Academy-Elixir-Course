defmodule BlogWeb.PostController do
  use BlogWeb, :controller

  alias Blog.Comments
  alias Blog.Comments.Comment
  alias Blog.Posts
  alias Blog.Posts.Post
  alias Blog.Tags

  plug :require_user_owns_post when action in [:edit, :update, :delete]

  def index(conn, params) do
    title_query = Map.get(params, "title")
    posts = Posts.list_posts(title_query)
    render(conn, :index, posts: posts, title_query: title_query)
  end

  def new(conn, _params) do
    changeset = Posts.change_post(%Post{})
    tag_options = tag_options()
    render(conn, :new, changeset: changeset, tag_options: tag_options)
  end

  def create(conn, %{"post" => post_params}) do
    tags = Map.get(post_params, "tag_ids", []) |> Enum.map(&Tags.get_tag!/1)

    case Posts.create_post(post_params, tags) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: ~p"/posts/#{post}")

      {:error, %Ecto.Changeset{} = changeset} ->
        tag_options = tag_options()
        render(conn, :new, changeset: changeset, tag_options: tag_options)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    tags = Posts.get_tags!(id)

    comment_changeset = Comments.change_comment(%Comment{})

    render(conn, :show,
      post: post,
      tags: tags,
      comment_changeset: comment_changeset,
      comments:
        Enum.map(post.comments, fn comment ->
          Comments.get_comment!(comment.id)
        end)
    )
  end

  def edit(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    post = Blog.Repo.preload(post, :tags, force: true)
    changeset = Posts.change_post(post)
    tag_options = tag_options(post.tags)
    render(conn, :edit, post: post, changeset: changeset, tag_options: tag_options)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Posts.get_post!(id)
    tags = Map.get(post_params, "tag_ids", []) |> Enum.map(&Tags.get_tag!/1)
    post = Blog.Repo.preload(post, :tags, force: true)

    case Posts.update_post(post, post_params, tags) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: ~p"/posts/#{post}")

      {:error, %Ecto.Changeset{} = changeset} ->
        tag_options = tag_options()
        render(conn, :edit, post: post, changeset: changeset, tag_options: tag_options)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    {:ok, _post} = Posts.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: ~p"/posts")
  end

  defp tag_options(selected_ids \\ []) do
    Tags.list_tags()
    |> Enum.map(fn tag ->
      [key: tag.name, value: tag.id, selected: tag.id in selected_ids]
    end)
  end

  defp require_user_owns_post(conn, _params) do
    post_id = conn.path_params["id"]
    post = Posts.get_post!(post_id)

    if conn.assigns[:current_user].id == post.created_user_id do
      conn
    else
      conn
      |> put_flash(:error, "You can only edit or delete your own posts.")
      |> redirect(to: ~p"/posts/#{post_id}")
      |> halt()
    end
  end
end
