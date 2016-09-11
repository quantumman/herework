# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :herework,
  ecto_repos: [Herework.Repo]

# Configures the endpoint
config :herework, Herework.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FyzocwlY1VmO0/0jbrJzMmqC4OjQKm4t4yC6J2nbLidLr7sgNiZNjJIzrq5SFfZh",
  render_errors: [view: Herework.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Herework.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
