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
      assert Enum.map(Posts.list_posts(), fn post -> post.id end) == [post.id]
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

      assert Enum.map(Posts.list_posts(), fn post -> post.id end) == [post.id]
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

      assert Enum.map(Posts.list_posts(), fn post ->
               Map.put(post, :tags, [])
             end) == [newer_post, post]
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

      assert Enum.map(Posts.list_posts(), fn post -> post.id end) == [post.id]
    end

    test "get_post!/1 returns the post with given id" do
      {_, post} = post_fixture()
      post = Map.put(post, :comments, [])
      post = Map.put(post, :user, [])
      assert Map.put(Map.put(Posts.get_post!(post.id), :user, []), :tags, []) == post
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

    test "create_post/1 without user" do
      no_user_attrs = %{
        title: "some title",
        content: "some content",
        published_on: ~D[2024-07-09],
        visibility: false
      }

      assert {:error, %Ecto.Changeset{}} = Posts.create_post(no_user_attrs)
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
      assert post.id == Posts.get_post!(post.id).id
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
      post_id = post.id
      # non-matching
      assert Posts.list_posts("Non-Matching") == []
      # exact match
      assert [%{id: ^post_id}] = Posts.list_posts("Title")
      # partial match end
      assert [%{id: ^post_id}] = Posts.list_posts("tle")
      # partial match front
      assert [%{id: ^post_id}] = Posts.list_posts("Titl")
      # partial match middle
      assert [%{id: ^post_id}] = Posts.list_posts("itl")
      # case insensitive lower
      assert [%{id: ^post_id}] = Posts.list_posts("title")
      # case insensitive upper
      assert [%{id: ^post_id}] = Posts.list_posts("TITLE")
      # case insensitive and partial match
      assert [%{id: ^post_id}] = Posts.list_posts("ITL")
      # empty
      assert [%{id: ^post_id}] = Posts.list_posts("")
    end
  end
end
