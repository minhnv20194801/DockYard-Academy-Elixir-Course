defmodule BlogWeb.PostControllerTest do
  use BlogWeb.ConnCase

  import Blog.PostsFixtures
  import Blog.UsersFixtures

  @create_attrs %{
    title: "some title",
    content: "some content",
    published_on: ~D[2024-07-08],
    visibility: true
  }
  @update_attrs %{
    title: "some updated title",
    content: "some updated content",
    published_on: ~D[2024-07-09],
    visibility: false
  }
  @invalid_attrs %{title: nil, content: nil, published_on: nil, visibility: nil}

  describe "index" do
    test "lists all posts", %{conn: conn} do
      conn = get(conn, ~p"/posts")
      assert html_response(conn, 200) =~ "Listing Posts"
    end

    test "lists all posts filter by visibility", %{conn: conn} do
      post = post_fixture(title: "invisible post", visibility: false)
      conn = get(conn, ~p"/posts")
      refute html_response(conn, 200) =~ post.title
    end

    test "list of posts from newest to oldest", %{conn: conn} do
      older_post = post_fixture(title: "older post")
      newer_post = post_fixture(title: "newer post", published_on: ~D[2024-07-10])
      conn = get(conn, ~p"/posts")
      response = html_response(conn, 200)
      assert elem(:binary.match(response, older_post.title), 0) > elem(:binary.match(response, newer_post.title), 0)
    end

    test "list of posts filter posts with future published date", %{conn: conn} do
      post = post_fixture(title: "future post", published_on: ~D[2025-01-01])
      conn = get(conn, ~p"/posts")
      refute html_response(conn, 200) =~ post.title
    end
  end

  describe "new post" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/posts/new")
      assert html_response(conn, 200) =~ "New Post"
    end
  end

  describe "create post" do
    test "redirects to show when data is valid", %{conn: conn} do
      user = user_fixture()
      post_create_attrs = Map.put(@create_attrs, :created_user_id, user.id)
      conn = post(conn, ~p"/posts", post: post_create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/posts/#{id}"

      conn = get(conn, ~p"/posts/#{id}")
      assert html_response(conn, 200) =~ "Post #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/posts", post: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Post"
    end
  end

  describe "edit post" do
    setup [:create_post]

    test "renders form for editing chosen post", %{conn: conn, post: post} do
      conn = get(conn, ~p"/posts/#{post}/edit")
      assert html_response(conn, 200) =~ "Edit Post"
    end
  end

  describe "update post" do
    setup [:create_post]

    test "redirects when data is valid", %{conn: conn, post: post} do
      conn = put(conn, ~p"/posts/#{post}", post: @update_attrs)
      assert redirected_to(conn) == ~p"/posts/#{post}"

      conn = get(conn, ~p"/posts/#{post}")
      assert html_response(conn, 200) =~ "some updated title"
    end

    test "renders errors when data is invalid", %{conn: conn, post: post} do
      conn = put(conn, ~p"/posts/#{post}", post: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Post"
    end
  end

  describe "delete post" do
    setup [:create_post]

    test "deletes chosen post", %{conn: conn, post: post} do
      conn = delete(conn, ~p"/posts/#{post}")
      assert redirected_to(conn) == ~p"/posts"

      assert_error_sent(404, fn ->
        get(conn, ~p"/posts/#{post}")
      end)
    end
  end

  describe "search post by title" do
    test "search for posts - non-matching", %{conn: conn} do
      post = post_fixture(title: "some title")
      conn = get(conn, ~p"/posts", title: "Non-Matching")
      refute html_response(conn, 200) =~ post.title
    end

    test "search for posts - exact match", %{conn: conn} do
      post = post_fixture(title: "some title")
      conn = get(conn, ~p"/posts", title: "some title")
      assert html_response(conn, 200) =~ post.title
    end

    test "search for posts - partial match", %{conn: conn} do
      post = post_fixture(title: "some title")
      conn = get(conn, ~p"/posts", title: "itl")
      assert html_response(conn, 200) =~ post.title
    end
  end

  defp create_post(_) do
    post = post_fixture()
    %{post: post}
  end
end
