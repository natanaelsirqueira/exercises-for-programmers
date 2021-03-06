use Mix.Config

config :movie_recommendations, :cache_key_ttl, 300

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :movie_recommendations, MovieRecommendationsWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
