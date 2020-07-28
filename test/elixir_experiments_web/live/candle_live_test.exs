defmodule ElixirExperimentsWeb.CandleLiveTest do
  use ElixirExperimentsWeb.ConnCase

  import Phoenix.LiveViewTest

  alias ElixirExperiments.QuietPlace

  @create_attrs %{ip_addr: "some ip_addr"}
  @update_attrs %{ip_addr: "some updated ip_addr"}
  @invalid_attrs %{ip_addr: nil}

  defp fixture(:candle) do
    {:ok, candle} = QuietPlace.create_candle(@create_attrs)
    candle
  end

  defp create_candle(_) do
    candle = fixture(:candle)
    %{candle: candle}
  end

  describe "Index" do
    setup [:create_candle]

    test "lists all candles", %{conn: conn, candle: candle} do
      {:ok, _index_live, html} = live(conn, Routes.candle_index_path(conn, :index))

      assert html =~ "Listing Candles"
      assert html =~ candle.ip_addr
    end

    test "saves new candle", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.candle_index_path(conn, :index))

      assert index_live |> element("a", "New Candle") |> render_click() =~
               "New Candle"

      assert_patch(index_live, Routes.candle_index_path(conn, :new))

      assert index_live
             |> form("#candle-form", candle: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#candle-form", candle: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.candle_index_path(conn, :index))

      assert html =~ "Candle created successfully"
      assert html =~ "some ip_addr"
    end

    test "updates candle in listing", %{conn: conn, candle: candle} do
      {:ok, index_live, _html} = live(conn, Routes.candle_index_path(conn, :index))

      assert index_live |> element("#candle-#{candle.id} a", "Edit") |> render_click() =~
               "Edit Candle"

      assert_patch(index_live, Routes.candle_index_path(conn, :edit, candle))

      assert index_live
             |> form("#candle-form", candle: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#candle-form", candle: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.candle_index_path(conn, :index))

      assert html =~ "Candle updated successfully"
      assert html =~ "some updated ip_addr"
    end

    test "deletes candle in listing", %{conn: conn, candle: candle} do
      {:ok, index_live, _html} = live(conn, Routes.candle_index_path(conn, :index))

      assert index_live |> element("#candle-#{candle.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#candle-#{candle.id}")
    end
  end

  describe "Show" do
    setup [:create_candle]

    test "displays candle", %{conn: conn, candle: candle} do
      {:ok, _show_live, html} = live(conn, Routes.candle_show_path(conn, :show, candle))

      assert html =~ "Show Candle"
      assert html =~ candle.ip_addr
    end

    test "updates candle within modal", %{conn: conn, candle: candle} do
      {:ok, show_live, _html} = live(conn, Routes.candle_show_path(conn, :show, candle))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Candle"

      assert_patch(show_live, Routes.candle_show_path(conn, :edit, candle))

      assert show_live
             |> form("#candle-form", candle: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#candle-form", candle: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.candle_show_path(conn, :show, candle))

      assert html =~ "Candle updated successfully"
      assert html =~ "some updated ip_addr"
    end
  end
end
