defmodule DocclaCommunityWeb.PageController do
  use DocclaCommunityWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    # render(conn, :home, layout: false)

    conn
    |> redirect(to: "/webinars")
  end
end
