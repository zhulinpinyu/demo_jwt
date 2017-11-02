# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :demo_jwt,
  ecto_repos: [DemoJwt.Repo]

# Configures the endpoint
config :demo_jwt, DemoJwtWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "LPe6zedXxRsSheHXtV2n93F6XSfKvknaqKff7+VK0BDOKZNzo5vX2rm8oXNBFtd5",
  render_errors: [view: DemoJwtWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: DemoJwt.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :demo_jwt, DemoJwt.Guardian,
  issuer: "demo_jwt",
  secret_key: "KAKOtE9GjyUFxykmZrHZ2UyHVugyu6rMaewlYMLFPUNrexrsX92D+P+fEB75MuE+"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
