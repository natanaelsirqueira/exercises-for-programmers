# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :word_frequency_finder, WordFrequencyFinderWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MXKOrd/9LdI/4XGzfJBWh+vhRQ+5CRT96+9/eycAF66kYZ6hv2P9v3VVFs4EOg7u",
  render_errors: [view: WordFrequencyFinderWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: WordFrequencyFinder.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
