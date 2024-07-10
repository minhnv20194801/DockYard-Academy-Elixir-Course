defmodule BlogWeb.CommentControllerTest do
  use BlogWeb.ConnCase

  import Blog.CommentsFixtures
  import Blog.PostsFixtures

  @create_attrs %{content: "some content"}
  @update_attrs %{content: "some updated content"}
  @invalid_attrs %{content: nil}

  describe "index" do
    test "lists all comments of a post", %{conn: conn} do
      post = post_fixture()
      conn = get(conn, ~p"/comments/#{post.id}")
      assert html_response(conn, 200) =~ "Listing Comments"
    end
  end

  describe "create comment" do
    test "redirects to show when data is valid", %{conn: conn} do
      post = post_fixture()
      valid_create_attrs = Map.put(@create_attrs, :post_id, post.id)
      conn = post(conn, ~p"/comments", comment: valid_create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/posts/#{id}"

      conn = get(conn, ~p"/posts/#{id}")
      assert html_response(conn, 200) =~ "some content"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/comments", comment: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Comment"
    end
  end

  describe "edit comment" do
    setup [:create_comment]

    test "renders form for editing chosen comment", %{conn: conn, comment: comment} do
      conn = get(conn, ~p"/comments/#{comment}/edit")
      assert html_response(conn, 200) =~ "Edit Comment"
    end
  end

  describe "update comment" do
    setup [:create_comment]

    test "redirects when data is valid", %{conn: conn, comment: comment} do
      conn = put(conn, ~p"/comments/#{comment}", comment: @update_attrs)
      assert redirected_to(conn) == ~p"/posts/#{comment.post_id}"

      conn = get(conn, ~p"/posts/#{comment.post_id}")
      assert html_response(conn, 200) =~ "some updated content"
    end

    test "renders errors when data is invalid", %{conn: conn, comment: comment} do
      conn = put(conn, ~p"/comments/#{comment}", comment: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Comment"
    end
  end

  describe "delete comment" do
    setup [:create_comment]

    test "deletes chosen comment", %{conn: conn, comment: comment} do
      conn = delete(conn, ~p"/comments/#{comment}")
      assert redirected_to(conn) == ~p"/posts/#{comment.post_id}"
    end
  end

  defp create_comment(_) do
    post = post_fixture()
    comment = comment_fixture(post_id: post.id)
    %{comment: comment}
  end
end
