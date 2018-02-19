# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :movie_recommendations, :api_key, "8a6dfe91"

# Configures the endpoint
config :movie_recommendations, MovieRecommendationsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1Uze1c3T0Tdawu+jn4mtEnra5yFUTPnSKHw02Y1JAqlhQMYnnapk8w0xp75BApjM",
  render_errors: [view: MovieRecommendationsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MovieRecommendations.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
