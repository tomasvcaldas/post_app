defmodule PostApp.Post do
  import Ecto.Query
  alias PostApp.Comment.Schema, as: CommentSchema
  alias PostApp.Post.Schema, as: PostSchema
  alias PostApp.Repo

  def create(%{title: title, body: body}) do
    %PostSchema{}
    |> PostSchema.changeset(%{title: title, body: body})
    |> Repo.insert()
  end

  def get_all do
    from(p in PostSchema, preload: [:comments])
    |> Repo.all()
  end

  def get(post_id) do
    from(p in PostSchema, where: p.id == ^post_id, preload: [:comments])
    |> Repo.one()
    |> case do
      %PostSchema{} = post -> {:ok, post}
      _ -> {:error, :not_found}
    end
  end

  def add_comment(%{body: body, post_id: post_id}) do
    %CommentSchema{}
    |> CommentSchema.changeset(%{body: body, post_id: post_id})
    |> Repo.insert()
  end
end
