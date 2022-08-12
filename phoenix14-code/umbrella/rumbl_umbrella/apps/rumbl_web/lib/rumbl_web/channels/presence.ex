#---
# Excerpted from "Programming Phoenix 1.4",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/phoenix14 for more book information.
#---
defmodule RumblWeb.Presence do
  use Phoenix.Presence,
    otp_app: :rumbl,
    pubsub_server: Rumbl.PubSub

  def fetch(_topic, entries) do
    users =
      entries
      |> Map.keys()
      |> Rumbl.Accounts.list_users_with_ids()
      |> Enum.into(%{}, fn user -> {to_string(user.id), %{username: user.username}} end)

    for {key, %{metas: metas}} <- entries, into: %{} do
      {key, %{metas: metas, user: users[key]}}
    end
  end
end
