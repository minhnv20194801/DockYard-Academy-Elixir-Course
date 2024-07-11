defmodule Blog.PostsTest do
  use Blog.DataCase

  alias Blog.Posts

  describe "posts" do
    alias Blog.Posts.Post

    import Blog.PostsFixtures
    import Blog.AccountsFixtures

    @invalid_attrs %{title: nil, content: nil, published_on: nil, visibility: nil}

    test "list_posts/0 returns all posts" do
      {_, post} = post_fixture()
      assert Posts.list_posts() == [post]
    end

    test "list_posts/0 returns only visible posts" do
      user = user_fixture()
      {_, post} = post_fixture()

      invisible_attrs = %{
        title: "some title",
        content: "some content",
        published_on: ~D[2024-07-09],
        visibility: false,
        created_user_id: user.id
      }

      Posts.create_post(invisible_attrs)

      assert Posts.list_posts() == [post]
    end

    test "list_posts/0 returns list of posts from newest to oldest" do
      user = user_fixture()
      {_, post} = post_fixture()

      newer_attrs = %{
        title: "some new title",
        content: "some content",
        published_on: ~D[2024-07-09],
        visibility: true,
        created_user_id: user.id
      }

      {:ok, %Post{} = newer_post} = Posts.create_post(newer_attrs)

      assert Posts.list_posts() == [newer_post, post]
    end

    test "list_posts/0 returns filter posts with future published date" do
      user = user_fixture()
      {_, post} = post_fixture()

      future_attrs = %{
        title: "some title",
        content: "some content",
        published_on: ~D[2025-07-09],
        visibility: true,
        created_user_id: user.id
      }

      Posts.create_post(future_attrs)

      assert Posts.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      {_, post} = post_fixture()
      post = Map.put(post, :comments, [])
      post = Map.put(post, :user, [])
      assert Map.put(Posts.get_post!(post.id), :user, []) == post
    end

    test "create_post/1 with valid data creates a post" do
      user = user_fixture()

      valid_attrs = %{
        title: "some title",
        content: "some content",
        published_on: ~D[2024-07-08],
        visibility: true,
        created_user_id: user.id
      }

      assert {:ok, %Post{} = post} = Posts.create_post(valid_attrs)
      assert post.title == "some title"
      assert post.content == "some content"
      assert post.published_on == ~D[2024-07-08]
      assert post.visibility == true
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      {_, post} = post_fixture()

      update_attrs = %{
        title: "some updated title",
        content: "some updated content",
        published_on: ~D[2024-07-09],
        visibility: false
      }

      assert {:ok, %Post{} = post} = Posts.update_post(post, update_attrs)
      assert post.title == "some updated title"
      assert post.content == "some updated content"
      assert post.published_on == ~D[2024-07-09]
      assert post.visibility == false
    end

    test "update_post/2 with invalid data returns error changeset" do
      {_, post} = post_fixture()
      post = Map.put(post, :user, [])
      post = Map.put(post, :comments, [])

      assert {:error, %Ecto.Changeset{}} = Posts.update_post(post, @invalid_attrs)
      assert post == Map.put(Posts.get_post!(post.id), :user, [])
    end

    test "delete_post/1 deletes the post" do
      {_, post} = post_fixture()
      assert {:ok, %Post{}} = Posts.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      {_, post} = post_fixture()
      assert %Ecto.Changeset{} = Posts.change_post(post)
    end

    test "list_posts/1 filters posts by partial and case-insensitive title" do
      {_, post} = post_fixture(title: "Title")

      # non-matching
      assert Posts.list_posts("Non-Matching") == []
      # exact match
      assert Posts.list_posts("Title") == [post]
      # partial match end
      assert Posts.list_posts("tle") == [post]
      # partial match front
      assert Posts.list_posts("Titl") == [post]
      # partial match middle
      assert Posts.list_posts("itl") == [post]
      # case insensitive lower
      assert Posts.list_posts("title") == [post]
      # case insensitive upper
      assert Posts.list_posts("TITLE") == [post]
      # case insensitive and partial match
      assert Posts.list_posts("ITL") == [post]
      # empty
      assert Posts.list_posts("") == [post]
    end
  end
end
