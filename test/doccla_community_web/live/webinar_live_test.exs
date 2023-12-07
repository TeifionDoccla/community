defmodule DocclaCommunityWeb.Events.WebinarLiveTest do
  use DocclaCommunityWeb.ConnCase

  import Phoenix.LiveViewTest
  import DocclaCommunity.EventsFixtures

  @create_attrs %{description: "some description", title: "some title", image: "some image", url: "some url", start_time: "2023-12-06T13:48:00"}
  @update_attrs %{description: "some updated description", title: "some updated title", image: "some updated image", url: "some updated url", start_time: "2023-12-07T13:48:00"}
  @invalid_attrs %{description: nil, title: nil, image: nil, url: nil, start_time: nil}

  defp create_webinar(_) do
    webinar = webinar_fixture()
    %{webinar: webinar}
  end

  describe "Index" do
    setup [:create_webinar]

    test "lists all webinars", %{conn: conn, webinar: webinar} do
      {:ok, _index_live, html} = live(conn, ~p"/webinars")

      assert html =~ "Listing Webinars"
      assert html =~ webinar.description
    end

    test "saves new webinar", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/webinars")

      assert index_live |> element("a", "New Webinar") |> render_click() =~
               "New Webinar"

      assert_patch(index_live, ~p"/webinars/new")

      assert index_live
             |> form("#webinar-form", webinar: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#webinar-form", webinar: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/webinars")

      html = render(index_live)
      assert html =~ "Webinar created successfully"
      assert html =~ "some description"
    end

    test "updates webinar in listing", %{conn: conn, webinar: webinar} do
      {:ok, index_live, _html} = live(conn, ~p"/webinars")

      assert index_live |> element("#webinars-#{webinar.id} a", "Edit") |> render_click() =~
               "Edit Webinar"

      assert_patch(index_live, ~p"/webinars/#{webinar}/edit")

      assert index_live
             |> form("#webinar-form", webinar: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#webinar-form", webinar: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/webinars")

      html = render(index_live)
      assert html =~ "Webinar updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes webinar in listing", %{conn: conn, webinar: webinar} do
      {:ok, index_live, _html} = live(conn, ~p"/webinars")

      assert index_live |> element("#webinars-#{webinar.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#webinars-#{webinar.id}")
    end
  end

  describe "Show" do
    setup [:create_webinar]

    test "displays webinar", %{conn: conn, webinar: webinar} do
      {:ok, _show_live, html} = live(conn, ~p"/webinars/#{webinar}")

      assert html =~ "Show Webinar"
      assert html =~ webinar.description
    end

    test "updates webinar within modal", %{conn: conn, webinar: webinar} do
      {:ok, show_live, _html} = live(conn, ~p"/webinars/#{webinar}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Webinar"

      assert_patch(show_live, ~p"/webinars/#{webinar}/show/edit")

      assert show_live
             |> form("#webinar-form", webinar: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#webinar-form", webinar: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/webinars/#{webinar}")

      html = render(show_live)
      assert html =~ "Webinar updated successfully"
      assert html =~ "some updated description"
    end
  end
end
