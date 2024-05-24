defmodule PostApp.Comment.Query do
  alias PostApp.Comment.Schema
  alias PostApp.Repo

  def create(%{body: body, post_id: post_id}) do
    %Schema{}
    |> Schema.changeset(%{body: body, post_id: post_id})
    |> Repo.insert()
  end
end
