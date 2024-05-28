defmodule PostApp.Comment.Schema do
  alias PostApp.Post.Schema, as: PostSchema

  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :body, :string
    belongs_to :post, PostSchema

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :post_id])
    |> validate_required([:body])
    |> assoc_constraint(:post)
  end
end
