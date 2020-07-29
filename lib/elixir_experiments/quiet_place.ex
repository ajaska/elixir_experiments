defmodule ElixirExperiments.QuietPlace do
  @moduledoc """
  The QuietPlace context.
  """

  import Ecto.Query, warn: false
  alias ElixirExperiments.Repo

  alias ElixirExperiments.QuietPlace.Candle

  @doc """
  Returns the list of candles.

  ## Examples

      iex> list_candles()
      [%Candle{}, ...]

  """
  def list_candles do
    Repo.all(Candle)
  end

  @doc """
  Gets a single candle.

  Raises `Ecto.NoResultsError` if the Candle does not exist.

  ## Examples

      iex> get_candle!(123)
      %Candle{}

      iex> get_candle!(456)
      ** (Ecto.NoResultsError)

  """
  def get_candle!(id), do: Repo.get!(Candle, id)

  @doc """
  Creates a candle.

  ## Examples

      iex> create_candle(%{field: value})
      {:ok, %Candle{}}

      iex> create_candle(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_candle(attrs \\ %{}) do
    %Candle{}
    |> Candle.changeset(attrs)
    |> Repo.insert()
    |> broadcast(:post_created)
  end

  @doc """
  Updates a candle.

  ## Examples

      iex> update_candle(candle, %{field: new_value})
      {:ok, %Candle{}}

      iex> update_candle(candle, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_candle(%Candle{} = candle, attrs) do
    candle
    |> Candle.changeset(attrs)
    |> Repo.update()
    |> broadcast(:post_updated)
  end

  @doc """
  Deletes a candle.

  ## Examples

      iex> delete_candle(candle)
      {:ok, %Candle{}}

      iex> delete_candle(candle)
      {:error, %Ecto.Changeset{}}

  """
  def delete_candle(%Candle{} = candle) do
    Repo.delete(candle)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking candle changes.

  ## Examples

      iex> change_candle(candle)
      %Ecto.Changeset{data: %Candle{}}

  """
  def change_candle(%Candle{} = candle, attrs \\ %{}) do
    Candle.changeset(candle, attrs)
  end

  def subscribe do
    Phoenix.PubSub.subscribe(ElixirExperiments.PubSub, "candles")
  end

  defp broadcast({:error, _reason} = error, _event), do: error
  defp broadcast({:ok, candle}, event) do
    Phoenix.PubSub.broadcast(ElixirExperiments.PubSub, "candles", {event, candle})
    {:ok, candle}
  end
end
