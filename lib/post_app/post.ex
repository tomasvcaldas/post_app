defmodule PostApp.Post do
  import Ecto.Query
  alias PostApp.Comment.Schema, as: CommentSchema
  alias PostApp.Post.Schema, as: PostSchema
  alias PostApp.Repo

  @type create_params :: %{
          title: String.t(),
          body: String.t()
        }

  @type add_comment_params :: %{
          body: String.t(),
          post_id: non_neg_integer()
        }

  @spec create(create_params()) :: {:ok, PostSchema.t()} | {:error, Ecto.Changeset.t()}
  def create(params) do
    %PostSchema{}
    |> PostSchema.changeset(params)
    |> Repo.insert()
  end

  @spec get_all() :: [PostSchema.t()]
  def get_all do
    from(p in PostSchema, preload: [:comments])
    |> Repo.all()
  end

  @spec get(non_neg_integer()) :: {:ok, PostSchema.t()} | {:error, atom()}
  def get(post_id) do
    from(p in PostSchema, where: p.id == ^post_id, preload: [:comments])
    |> Repo.one()
    |> case do
      %PostSchema{} = post -> {:ok, post}
      _ -> {:error, :not_found}
    end
  end

  @spec add_comment(add_comment_params()) ::
          {:ok, CommentSchema.t()} | {:error, Ecto.Changeset.t()}
  def add_comment(params) do
    %CommentSchema{}
    |> CommentSchema.changeset(params)
    |> Repo.insert()
  end
end
