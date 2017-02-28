# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :dpw,
  namespace: DPW,
  ecto_repos: [DPW.Repo]

# Configures the endpoint
config :dpw, DPW.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YXqjnUDl65fOROaKSrngRDulmGeB/p9OLf3cfDaicrjMkQmtPurG5qDvcibZXYb0",
  render_errors: [view: DPW.ErrorView, accepts: ~w(html json)],
  pubsub: [name: DPW.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
