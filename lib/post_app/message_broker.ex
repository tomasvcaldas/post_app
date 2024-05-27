defmodule PostApp.MessageBroker do
  alias Phoenix.PubSub

  def subscribe(post_id) do
    PubSub.subscribe(PostApp.PubSub, "post_" <> post_id)
  end

  def broadcast({:ok, %{post_id: post_id}}) do
    PubSub.broadcast(
      PostApp.PubSub,
      "post_" <> to_string(post_id),
      {:comment_created, post_id}
    )

    {:ok, post_id}
  end

  def broadcast({:error, %Ecto.Changeset{}}) do
    {:error, :failure_broadcasting}
  end
end
