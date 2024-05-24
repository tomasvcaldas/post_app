defmodule PostApp.Post.Query do
  import Ecto.Query
  alias PostApp.Post.Schema
  alias PostApp.Repo

  def create(%{title: title, body: body}) do
    %Schema{}
    |> Schema.changeset(%{title: title, body: body})
    |> Repo.insert()
  end

  def get_all do
    from(p in Schema, preload: [:comments])
    |> Repo.all()
  end

  def get(post_id) do
    from(p in Schema, where: p.id == ^post_id, preload: [:comments])
    |> Repo.one()
  end
end
