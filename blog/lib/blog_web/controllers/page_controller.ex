defmodule BlogWeb.PageController do
  use BlogWeb, :controller

  alias Blog.Posts

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    posts = Posts.list_posts()
    render(conn, :home, layout: false, posts: posts)
  end
end
