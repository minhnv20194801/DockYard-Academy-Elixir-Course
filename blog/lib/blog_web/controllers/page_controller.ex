defmodule BlogWeb.PageController do
  use BlogWeb, :controller

  alias Blog.Posts

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    posts =
      Posts.list_posts()
      |> Enum.map(fn post ->
        Map.put(post, :tags, Posts.get_tags!(post.id))
      end)
    render(conn, :home, layout: false, posts: posts)
  end
end
