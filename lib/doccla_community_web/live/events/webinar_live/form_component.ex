defmodule DocclaCommunityWeb.Events.WebinarLive.FormComponent do
  use DocclaCommunityWeb, :live_component

  alias DocclaCommunity.Events

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage webinar records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="webinar-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:image]} type="text" label="Image" />
        <.input field={@form[:url]} type="text" label="Url" />
        <.input field={@form[:start_time]} type="datetime-local" label="Start time" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Webinar</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{webinar: webinar} = assigns, socket) do
    changeset = Events.change_webinar(webinar)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"webinar" => webinar_params}, socket) do
    changeset =
      socket.assigns.webinar
      |> Events.change_webinar(webinar_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"webinar" => webinar_params}, socket) do
    save_webinar(socket, socket.assigns.action, webinar_params)
  end

  defp save_webinar(socket, :edit, webinar_params) do
    case Events.update_webinar(socket.assigns.webinar, webinar_params) do
      {:ok, webinar} ->
        notify_parent({:saved, webinar})

        {:noreply,
         socket
         |> put_flash(:info, "Webinar updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_webinar(socket, :new, webinar_params) do
    case Events.create_webinar(webinar_params) do
      {:ok, webinar} ->
        notify_parent({:saved, webinar})

        {:noreply,
         socket
         |> put_flash(:info, "Webinar created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
