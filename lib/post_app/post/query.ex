defmodule PostApp.Post.Query do
  import Ecto.Query
  alias PostApp.Post.Schema
  alias PostApp.Repo

  def get(post_id) do
    from(p in Schema, where: p.id == ^post_id, preload: [:comments])
    |> Repo.one()
  end
end
