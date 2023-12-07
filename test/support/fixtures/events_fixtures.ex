defmodule DocclaCommunity.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DocclaCommunity.Events` context.
  """

  @doc """
  Generate a webinar.
  """
  def webinar_fixture(attrs \\ %{}) do
    {:ok, webinar} =
      attrs
      |> Enum.into(%{
        description: "some description",
        image: "some image",
        start_time: ~N[2023-12-06 13:48:00],
        title: "some title",
        url: "some url"
      })
      |> DocclaCommunity.Events.create_webinar()

    webinar
  end
end
