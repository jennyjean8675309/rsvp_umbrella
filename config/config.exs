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

config :rsvp, Rsvp.Repo,
  database: "rsvp",
  hostname:  "localhost"

config :rsvp, ecto_repos: [Rsvp.Repo]

config :rsvp_web,
  generators: [context_app: :rsvp]

# Configures the endpoint
config :rsvp_web, RsvpWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/E4NFfQD1kaB0aAbfIZetyksM5DCGVLA2RlxhZSZAU25MucXpjfVYWjtIKk/PHPA",
  render_errors: [view: RsvpWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Rsvp.PubSub,
  live_view: [signing_salt: "ERpa5wl8"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
