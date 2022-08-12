defmodule RumblWeb.PageController do
  use RumblWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def e500(conn, _params) do
    render(conn, "500.html")
  end
end
