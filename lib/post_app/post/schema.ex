defmodule PostApp.Post.Schema do
  alias PostApp.Comment.Schema, as: CommentSchema
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :body, :string
    field :title, :string
    # by detailt the foreign_key is the name of the schema + _id and the references default is :id
    has_many(:comments, CommentSchema, foreign_key: :post_id)

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end
