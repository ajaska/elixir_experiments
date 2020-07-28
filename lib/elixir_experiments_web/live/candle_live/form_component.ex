defmodule ElixirExperimentsWeb.CandleLive.FormComponent do
  use ElixirExperimentsWeb, :live_component

  alias ElixirExperiments.QuietPlace

  @impl true
  def update(%{candle: candle} = assigns, socket) do
    changeset = QuietPlace.change_candle(candle)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"candle" => candle_params}, socket) do
    changeset =
      socket.assigns.candle
      |> QuietPlace.change_candle(candle_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"candle" => candle_params}, socket) do
    save_candle(socket, socket.assigns.action, candle_params)
  end

  defp save_candle(socket, :edit, candle_params) do
    case QuietPlace.update_candle(socket.assigns.candle, candle_params) do
      {:ok, _candle} ->
        {:noreply,
         socket
         |> put_flash(:info, "Candle updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_candle(socket, :new, candle_params) do
    case QuietPlace.create_candle(candle_params) do
      {:ok, _candle} ->
        {:noreply,
         socket
         |> put_flash(:info, "Candle created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
