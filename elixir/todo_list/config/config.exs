# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :todo_list,
  ecto_repos: [TodoList.Repo]

# Configures the endpoint
config :todo_list, TodoList.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "eqyKlQkIHzLM6GYtp3vD3ugdx0+2xmzAE3qe76KzCC+Q8TwugfUO8rpMkF8vkic/",
  render_errors: [view: TodoList.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TodoList.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
