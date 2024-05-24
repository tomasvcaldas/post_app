defmodule PostAppWeb.PageController do
  use PostAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
