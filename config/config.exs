use Mix.Config

# General application configuration
config :es,
	namespace: Es,
  ecto_repos: [Es.Repo]

config :commanded_ecto_projections,
  repo: Es.Repo

config :commanded,
 	event_store_adapter: Commanded.EventStore.Adapters.EventStore

config :vex,
  sources: [
    Es.Accounts.Validators,
    Es.Support.Validators,
    Vex.Validators
  ]

# Configures the endpoint
config :es, EsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "a11k8ccJEoFLmLInctj4OaOAECwdatOL261OxcwfLYaSFADPgI1SJaj7D8Ku1S3k",
  render_errors: [view: EsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Es.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
