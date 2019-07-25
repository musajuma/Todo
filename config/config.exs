# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :todo,
  ecto_repos: [Todo.Repo]

# Configures the endpoint
config :todo, TodoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+DRpDfts78HPAt77mLFff9Kd5P9R3WSRGlS8UHqwmvwEuLjRhTh7Yr8T9vWucA2C",
  render_errors: [view: TodoWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Todo.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :todo, TodoWeb.Mailer, adapter: Bamboo.LocalAdapter

# Configures Phauxth authentication
config :phauxth,
  user_context: Todo.Auth,
  crypto_module: Bcrypt,
  token_module: TodoWeb.Auth.Token

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"