defmodule RumblWeb.PageView do
  use RumblWeb, :view

  def render("500.html", _assigns) do
    "Internal server error"
  end
end
