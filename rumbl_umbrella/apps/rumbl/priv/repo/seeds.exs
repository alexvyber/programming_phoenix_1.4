alias Rumbl.Multimedia

for category <- ~w(Action Shit Drama Pussy Romance Cunt Sci-Fi Porn) do
  Multimedia.create_category!(category)
end

{:ok, _} = Rumbl.Accounts.create_user(%{name: "Wolfram", username: "wolfram"})
