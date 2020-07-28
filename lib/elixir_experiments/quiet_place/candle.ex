defmodule ElixirExperiments.QuietPlace.Candle do
  use Ecto.Schema
  import Ecto.Changeset

  schema "candles" do
    field :ip_addr, :string, default: "1.1.1.1"

    timestamps()
  end

  @doc false
  def changeset(candle, attrs) do
    candle
    |> cast(attrs, [])
    |> validate_required([])
  end
end
