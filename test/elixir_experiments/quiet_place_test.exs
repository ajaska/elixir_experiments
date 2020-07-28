defmodule ElixirExperiments.QuietPlaceTest do
  use ElixirExperiments.DataCase

  alias ElixirExperiments.QuietPlace

  describe "candles" do
    alias ElixirExperiments.QuietPlace.Candle

    @valid_attrs %{ip_addr: "some ip_addr"}
    @update_attrs %{ip_addr: "some updated ip_addr"}
    @invalid_attrs %{ip_addr: nil}

    def candle_fixture(attrs \\ %{}) do
      {:ok, candle} =
        attrs
        |> Enum.into(@valid_attrs)
        |> QuietPlace.create_candle()

      candle
    end

    test "list_candles/0 returns all candles" do
      candle = candle_fixture()
      assert QuietPlace.list_candles() == [candle]
    end

    test "get_candle!/1 returns the candle with given id" do
      candle = candle_fixture()
      assert QuietPlace.get_candle!(candle.id) == candle
    end

    test "create_candle/1 with valid data creates a candle" do
      assert {:ok, %Candle{} = candle} = QuietPlace.create_candle(@valid_attrs)
      assert candle.ip_addr == "some ip_addr"
    end

    test "create_candle/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = QuietPlace.create_candle(@invalid_attrs)
    end

    test "update_candle/2 with valid data updates the candle" do
      candle = candle_fixture()
      assert {:ok, %Candle{} = candle} = QuietPlace.update_candle(candle, @update_attrs)
      assert candle.ip_addr == "some updated ip_addr"
    end

    test "update_candle/2 with invalid data returns error changeset" do
      candle = candle_fixture()
      assert {:error, %Ecto.Changeset{}} = QuietPlace.update_candle(candle, @invalid_attrs)
      assert candle == QuietPlace.get_candle!(candle.id)
    end

    test "delete_candle/1 deletes the candle" do
      candle = candle_fixture()
      assert {:ok, %Candle{}} = QuietPlace.delete_candle(candle)
      assert_raise Ecto.NoResultsError, fn -> QuietPlace.get_candle!(candle.id) end
    end

    test "change_candle/1 returns a candle changeset" do
      candle = candle_fixture()
      assert %Ecto.Changeset{} = QuietPlace.change_candle(candle)
    end
  end
end
