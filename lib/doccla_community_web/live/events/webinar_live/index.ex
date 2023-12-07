defmodule DocclaCommunityWeb.Events.WebinarLive.Index do
  use DocclaCommunityWeb, :live_view

  alias DocclaCommunity.Events
  alias DocclaCommunity.Events.Webinar

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :webinars, Events.list_webinars())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Webinar")
    |> assign(:webinar, Events.get_webinar!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Webinar")
    |> assign(:webinar, %Webinar{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Webinars")
    |> assign(:webinar, nil)
  end

  @impl true
  def handle_info({DocclaCommunityWeb.Events.WebinarLive.FormComponent, {:saved, webinar}}, socket) do
    {:noreply, stream_insert(socket, :webinars, webinar)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    webinar = Events.get_webinar!(id)
    {:ok, _} = Events.delete_webinar(webinar)

    {:noreply, stream_delete(socket, :webinars, webinar)}
  end
end
