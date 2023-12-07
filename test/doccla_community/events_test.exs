defmodule DocclaCommunity.EventsTest do
  use DocclaCommunity.DataCase

  alias DocclaCommunity.Events

  describe "webinars" do
    alias DocclaCommunity.Events.Webinar

    import DocclaCommunity.EventsFixtures

    @invalid_attrs %{description: nil, title: nil, image: nil, url: nil, start_time: nil}

    test "list_webinars/0 returns all webinars" do
      webinar = webinar_fixture()
      assert Events.list_webinars() == [webinar]
    end

    test "get_webinar!/1 returns the webinar with given id" do
      webinar = webinar_fixture()
      assert Events.get_webinar!(webinar.id) == webinar
    end

    test "create_webinar/1 with valid data creates a webinar" do
      valid_attrs = %{description: "some description", title: "some title", image: "some image", url: "some url", start_time: ~N[2023-12-06 13:48:00]}

      assert {:ok, %Webinar{} = webinar} = Events.create_webinar(valid_attrs)
      assert webinar.description == "some description"
      assert webinar.title == "some title"
      assert webinar.image == "some image"
      assert webinar.url == "some url"
      assert webinar.start_time == ~N[2023-12-06 13:48:00]
    end

    test "create_webinar/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_webinar(@invalid_attrs)
    end

    test "update_webinar/2 with valid data updates the webinar" do
      webinar = webinar_fixture()
      update_attrs = %{description: "some updated description", title: "some updated title", image: "some updated image", url: "some updated url", start_time: ~N[2023-12-07 13:48:00]}

      assert {:ok, %Webinar{} = webinar} = Events.update_webinar(webinar, update_attrs)
      assert webinar.description == "some updated description"
      assert webinar.title == "some updated title"
      assert webinar.image == "some updated image"
      assert webinar.url == "some updated url"
      assert webinar.start_time == ~N[2023-12-07 13:48:00]
    end

    test "update_webinar/2 with invalid data returns error changeset" do
      webinar = webinar_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_webinar(webinar, @invalid_attrs)
      assert webinar == Events.get_webinar!(webinar.id)
    end

    test "delete_webinar/1 deletes the webinar" do
      webinar = webinar_fixture()
      assert {:ok, %Webinar{}} = Events.delete_webinar(webinar)
      assert_raise Ecto.NoResultsError, fn -> Events.get_webinar!(webinar.id) end
    end

    test "change_webinar/1 returns a webinar changeset" do
      webinar = webinar_fixture()
      assert %Ecto.Changeset{} = Events.change_webinar(webinar)
    end
  end
end
