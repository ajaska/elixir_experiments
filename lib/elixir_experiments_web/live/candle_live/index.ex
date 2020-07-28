defmodule ElixirExperimentsWeb.CandleLive.Index do
  use ElixirExperimentsWeb, :live_view

  alias ElixirExperiments.QuietPlace
  alias ElixirExperiments.QuietPlace.Candle

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :candles, list_candles())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Candle")
    |> assign(:candle, QuietPlace.get_candle!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Candle")
    |> assign(:candle, %Candle{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Candles")
    |> assign(:candle, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    candle = QuietPlace.get_candle!(id)
    {:ok, _} = QuietPlace.delete_candle(candle)

    {:noreply, assign(socket, :candles, list_candles())}
  end

  defp list_candles do
    QuietPlace.list_candles()
  end
end
