defmodule PostAppWeb.Router do
  use PostAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PostAppWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", PostAppWeb do
    pipe_through :browser

    live "/post/:id", Live.Show, :show
  end
end
