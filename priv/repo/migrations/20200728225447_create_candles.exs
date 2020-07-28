defmodule ElixirExperiments.Repo.Migrations.CreateCandles do
  use Ecto.Migration

  def change do
    create table(:candles) do
      add :ip_addr, :string

      timestamps()
    end

  end
end
