defmodule PostApp.Repo do
  use Ecto.Repo,
    otp_app: :post_app,
    adapter: Ecto.Adapters.Postgres
end
