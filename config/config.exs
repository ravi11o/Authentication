# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :google_auth,
  ecto_repos: [GoogleAuth.Repo]

# Configures the endpoint
config :google_auth, GoogleAuth.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "y+n7PfSvRvxD4H4ieOz/HSBoT2wzRXBe/28VKlU5eIjMih8vFFYnOWaZeGNLfbSt",
  render_errors: [view: GoogleAuth.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GoogleAuth.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
