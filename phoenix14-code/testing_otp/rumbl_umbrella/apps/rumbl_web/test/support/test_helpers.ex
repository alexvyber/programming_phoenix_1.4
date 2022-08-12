#---
# Excerpted from "Programming Phoenix 1.4",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/phoenix14 for more book information.
#---
defmodule RumblWeb.TestHelpers do
  
  defp default_user() do
    %{
      name: "Some User",
      username: "user#{System.unique_integer([:positive])}",
      password: "supersecret"
    }
  end
  
  def insert_user(attrs \\ %{}) do
    {:ok, user} = 
      attrs
      |> Enum.into(default_user())
      |> Rumbl.Accounts.register_user
    
    user
  end

  defp default_video() do
    %{
      url: "test@example.com", 
      description: "a video", 
      body: "body"
    }
  end
  
  def insert_video(user, attrs \\ %{}) do
    video_fields = Enum.into(attrs, default_video())
    {:ok, video} = Rumbl.Multimedia.create_video(user, video_fields)
    video
  end

  def login(%{conn: conn, login_as: username}) do
    user = insert_user(username: username)
    {Plug.Conn.assign(conn, :current_user, user), user}
  end
  def login(%{conn: conn}), do: {conn, :logged_out}
end
