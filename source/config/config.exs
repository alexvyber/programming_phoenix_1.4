#---
# Excerpted from "Programming Phoenix 1.4",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/phoenix14 for more book information.
#---
# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :rumbl,
  ecto_repos: [Rumbl.Repo]

config :rumbl_web,
  ecto_repos: [Rumbl.Repo],
  generators: [context_app: :rumbl]

# Configures the endpoint
config :rumbl_web, RumblWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2CvdnUV9QagJ7BE/Pf5hHCMZmAbu3a6asBT5dBjVp4F/H7qiO3MSipYy7j4un1e0",
  render_errors: [view: RumblWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Rumbl.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
