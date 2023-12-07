defmodule DocclaCommunityWeb.Events.WebinarController do
  use DocclaCommunityWeb, :controller

  alias DocclaCommunity.Events
  alias DocclaCommunity.Events.Webinar

  action_fallback DocclaCommunityWeb.FallbackController

  def index(conn, _params) do
    webinars = Events.list_webinars()
    render(conn, :index, webinars: webinars)
  end

  def create(conn, %{"webinar" => webinar_params}) do
    with {:ok, %Webinar{} = webinar} <- Events.create_webinar(webinar_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/webinars/#{webinar}")
      |> render(:show, webinar: webinar)
    end
  end

  def show(conn, %{"id" => id}) do
    webinar = Events.get_webinar!(id)
    render(conn, :show, webinar: webinar)
  end

  def update(conn, %{"id" => id, "webinar" => webinar_params}) do
    webinar = Events.get_webinar!(id)

    with {:ok, %Webinar{} = webinar} <- Events.update_webinar(webinar, webinar_params) do
      render(conn, :show, webinar: webinar)
    end
  end

  def delete(conn, %{"id" => id}) do
    webinar = Events.get_webinar!(id)

    with {:ok, %Webinar{}} <- Events.delete_webinar(webinar) do
      send_resp(conn, :no_content, "")
    end
  end
end
