defmodule ElixirExperimentsWeb.CandleLive.Index do
  use ElixirExperimentsWeb, :live_view

  alias ElixirExperiments.QuietPlace
  alias ElixirExperiments.QuietPlace.Candle

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: QuietPlace.subscribe()
    {:ok, assign(socket, :candles, list_candles())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Candles")
    |> assign(:candle, nil)
  end

  def handle_event("new", _params, socket) do
    QuietPlace.create_candle()
    {:noreply, socket}
  end

  @impl true
  def handle_info({:candle_created, candle}, socket) do
    {:noreply, update(socket, :candles, fn candles -> [candle | candles] end)}
  end

  defp list_candles do
    QuietPlace.list_candles()
  end
end
