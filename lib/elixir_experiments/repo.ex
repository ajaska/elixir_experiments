defmodule ElixirExperiments.Repo do
  use Ecto.Repo,
    otp_app: :elixir_experiments,
    adapter: Ecto.Adapters.Postgres
end
