defmodule PostApp.MessageBroker do
  alias Phoenix.PubSub

  @spec subscribe(non_neg_integer() | String.t()) :: :ok
  def subscribe(post_id) do
    PubSub.subscribe(PostApp.PubSub, "post_" <> to_string(post_id))
  end

  @spec broadcast(non_neg_integer() | String.t()) :: :ok | {:error, atom()}
  def broadcast(post_id) do
    PubSub.broadcast(
      PostApp.PubSub,
      "post_" <> to_string(post_id),
      {:comment_created, post_id}
    )
  end
end
