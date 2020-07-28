defmodule ElixirExperimentsWeb.CandleLive.Show do
  use ElixirExperimentsWeb, :live_view

  alias ElixirExperiments.QuietPlace

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:candle, QuietPlace.get_candle!(id))}
  end

  defp page_title(:show), do: "Show Candle"
  defp page_title(:edit), do: "Edit Candle"
end
