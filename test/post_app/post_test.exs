defmodule PostApp.PostTest do
  use ExUnit.Case

  alias Support.Factory
  alias PostApp.Post

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(PostApp.Repo)
  end

  describe "create/1" do
    test "creates a post with given parameters" do
      assert {:ok, post} = Post.create(%{title: "title", body: "body"})

      assert post.title == "title"
      assert post.body == "body"
    end

    test "returns error on missing required parameters" do
      assert {:error, changeset} = Post.create(%{})

      assert changeset.errors[:title] == {"can't be blank", [validation: :required]}
      assert changeset.errors[:body] == {"can't be blank", [validation: :required]}
    end

    test "returns error on invalid parameters" do
      assert {:error, changeset} = Post.create(%{title: 123, body: "body"})

      assert changeset.errors[:title] == {"is invalid", [type: :string, validation: :cast]}
    end
  end

  describe "get_all/0" do
    test "returns all posts and related comments" do
      post1 = Factory.insert(:post)
      post1_comment = Factory.insert(:comment, post: post1)
      post2 = Factory.insert(:post)
      post2_comment = Factory.insert(:comment, post: post2)

      assert [returned_post1, returned_post2] = Post.get_all()
      assert returned_post1.id == post1.id
      assert returned_post2.id == post2.id

      Enum.find(returned_post1.comments, fn comment -> comment.id == post1_comment.id end)
      Enum.find(returned_post2.comments, fn comment -> comment.id == post2_comment.id end)
    end

    test "returns empty list on no posts" do
      assert [] = Post.get_all()
    end
  end

  describe "get/1" do
    test "returns the post with the given id and related comments" do
      post = Factory.insert(:post)
      comment = Factory.insert(:comment, post: post)

      assert {:ok, returned_post} = Post.get(post.id)
      assert returned_post.id == post.id
      assert Enum.find(returned_post.comments, fn c -> c.id == comment.id end)
    end

    test "returns error on non-existing post" do
      assert {:error, :not_found} = Post.get(0)
    end
  end

  describe "add_comment/1" do
    test "adds a comment to the post with the given id" do
      post = Factory.insert(:post)
      params = %{body: "comment body", post_id: post.id}

      assert {:ok, comment} = Post.add_comment(params)
      assert comment.body == "comment body"
      assert comment.post_id == post.id
    end

    test "returns error on missing required parameters" do
      assert {:error, changeset} = Post.add_comment(%{})

      assert changeset.errors[:body] == {"can't be blank", [validation: :required]}
    end

    test "returns error on non existing post" do
      assert {:error, changeset} = Post.add_comment(%{body: "comment body", post_id: 0})

      assert changeset.errors[:post] ==
               {"does not exist", [constraint: :assoc, constraint_name: "comments_post_id_fkey"]}
    end
  end
end
