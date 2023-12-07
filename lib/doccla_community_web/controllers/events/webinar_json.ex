defmodule DocclaCommunityWeb.Events.WebinarJSON do
  alias DocclaCommunity.Events.Webinar

  @doc """
  Renders a list of webinars.
  """
  def index(%{webinars: webinars}) do
    %{data: for(webinar <- webinars, do: data(webinar))}
  end

  @doc """
  Renders a single webinar.
  """
  def show(%{webinar: webinar}) do
    %{data: data(webinar)}
  end

  defp data(%Webinar{} = webinar) do
    %{
      id: webinar.id,
      host_id: webinar.host_id,
      description: webinar.description,
      title: webinar.title,
      image: webinar.image,
      url: webinar.url,
      start_time: webinar.start_time
    }
  end
end
