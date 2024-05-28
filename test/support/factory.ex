defmodule Support.Factory do
  use ExMachina.Ecto, repo: PostApp.Repo

  alias PostApp.Comment.Schema, as: CommentSchema
  alias PostApp.Post.Schema, as: PostSchema

  def comment_factory do
    %CommentSchema{
      body: "Comment body",
      post: build(:post)
    }
  end

  def post_factory do
    %PostSchema{
      body: "Post body",
      title: "Post title"
    }
  end
end
