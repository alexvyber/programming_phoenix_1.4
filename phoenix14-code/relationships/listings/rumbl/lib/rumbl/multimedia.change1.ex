#---
# Excerpted from "Programming Phoenix 1.4",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/phoenix14 for more book information.
#---
defmodule Rumbl.Multimedia do
  import Ecto.Query, warn: false
  alias Rumbl.Repo
  alias Rumbl.Multimedia.Video

  def list_videos do
    Repo.all(Video)
  end

  def get_video!(id), do: Repo.get!(Video, id)

  def update_video(%Video{} = video, attrs) do
    video
    |> Video.changeset(attrs)
    |> Repo.update()
  end

  def delete_video(%Video{} = video) do
    Repo.delete(video)
  end

  alias Rumbl.Accounts

  def create_video(%Accounts.User{} = user, attrs \\ %{}) do
    %Video{}
    |> Video.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  def change_video(%Video{} = video) do
    Video.changeset(video, %{})
  end
end
