defmodule DocclaCommunityWeb.Events.WebinarLive.Show do
  use DocclaCommunityWeb, :live_view

  alias DocclaCommunity.Events

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:webinar, Events.get_webinar!(id))}
  end

  defp page_title(:show), do: "Show Webinar"
  defp page_title(:edit), do: "Edit Webinar"
end
