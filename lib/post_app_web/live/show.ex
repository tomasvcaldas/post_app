defmodule PostAppWeb.Live.Show do
  use PostAppWeb, :live_view

  alias PostApp.Post
  alias PostApp.MessageBroker

  @impl true
  def mount(%{"id" => post_id}, _session, socket) do
    if connected?(socket), do: MessageBroker.subscribe(post_id)

    Post.get(post_id)
    |> case do
      {:ok, post} ->
        {:ok, assign(socket, :post, post)}

      _ ->
        raise PostApp.Live.PostNotFound
    end
  end

  @impl true
  def handle_event("save", %{"post_id" => post_id, "body" => body}, socket) do
    with {:ok, _comment} <- Post.add_comment(%{post_id: post_id, body: body}),
         :ok <- MessageBroker.broadcast(post_id) do
      {:noreply, socket}
    else
      _ -> {:noreply, put_flash(socket, :error, "Error saving comment")}
    end
  end

  @impl true
  def handle_info({:comment_created, post_id}, socket) do
    Post.get(post_id)
    |> case do
      {:ok, post} ->
        {:noreply, assign(socket, :post, post)}

      {:error, _reason} ->
        {:noreply, put_flash(socket, :error, "Post not found")}
    end
  end
end
