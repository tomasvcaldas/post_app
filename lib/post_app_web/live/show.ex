defmodule PostAppWeb.Live.Show do
  use PostAppWeb, :live_view

  alias PostApp.Comment.Query, as: CommentQuery
  alias PostApp.Post.Query, as: PostQuery

  @impl true
  def mount(_, _session, socket) do
    posts = PostQuery.get_all()
    {:ok, assign(socket, :posts, posts)}
  end

  @impl true
  def handle_event("save", %{"post_id" => post_id, "body" => body}, socket) do
    case CommentQuery.create(%{post_id: post_id, body: body}) do
      {:ok, comment} ->
        IO.inspect(label: "comment created")
        {:noreply, assign(socket, :comments, [comment | socket.assigns.comments])}

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(label: "failed comment")
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
