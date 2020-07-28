# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :elixir_experiments,
  ecto_repos: [ElixirExperiments.Repo]

# Configures the endpoint
config :elixir_experiments, ElixirExperimentsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "IqAaxzPVeO2mA+tF2XHhDo5sfrMrn1GYfF3LaoefzlRxOeDISI+NqZHsP7kO09Uo",
  render_errors: [view: ElixirExperimentsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ElixirExperiments.PubSub,
  live_view: [signing_salt: "QJjykRic"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
