defmodule CodeCollabWeb.LiveCodeLiveTest do
  use CodeCollabWeb.ConnCase

  import Phoenix.LiveViewTest
  import CodeCollab.CodeEditorFixtures

  @create_attrs %{code: "some code"}
  @update_attrs %{code: "some updated code"}
  @invalid_attrs %{code: nil}

  defp create_live_code(_) do
    live_code = live_code_fixture()
    %{live_code: live_code}
  end

  describe "Index" do
    setup [:create_live_code]

    test "lists all live_codes", %{conn: conn, live_code: live_code} do
      {:ok, _index_live, html} = live(conn, ~p"/live_codes")

      assert html =~ "Listing Live codes"
      assert html =~ live_code.code
    end

    test "saves new live_code", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/live_codes")

      assert index_live |> element("a", "New Live code") |> render_click() =~
               "New Live code"

      assert_patch(index_live, ~p"/live_codes/new")

      assert index_live
             |> form("#live_code-form", live_code: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#live_code-form", live_code: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/live_codes")

      html = render(index_live)
      assert html =~ "Live code created successfully"
      assert html =~ "some code"
    end

    test "updates live_code in listing", %{conn: conn, live_code: live_code} do
      {:ok, index_live, _html} = live(conn, ~p"/live_codes")

      assert index_live |> element("#live_codes-#{live_code.id} a", "Edit") |> render_click() =~
               "Edit Live code"

      assert_patch(index_live, ~p"/live_codes/#{live_code}/edit")

      assert index_live
             |> form("#live_code-form", live_code: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#live_code-form", live_code: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/live_codes")

      html = render(index_live)
      assert html =~ "Live code updated successfully"
      assert html =~ "some updated code"
    end

    test "deletes live_code in listing", %{conn: conn, live_code: live_code} do
      {:ok, index_live, _html} = live(conn, ~p"/live_codes")

      assert index_live |> element("#live_codes-#{live_code.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#live_codes-#{live_code.id}")
    end
  end

  describe "Show" do
    setup [:create_live_code]

    test "displays live_code", %{conn: conn, live_code: live_code} do
      {:ok, _show_live, html} = live(conn, ~p"/live_codes/#{live_code}")

      assert html =~ "Show Live code"
      assert html =~ live_code.code
    end

    test "updates live_code within modal", %{conn: conn, live_code: live_code} do
      {:ok, show_live, _html} = live(conn, ~p"/live_codes/#{live_code}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Live code"

      assert_patch(show_live, ~p"/live_codes/#{live_code}/show/edit")

      assert show_live
             |> form("#live_code-form", live_code: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#live_code-form", live_code: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/live_codes/#{live_code}")

      html = render(show_live)
      assert html =~ "Live code updated successfully"
      assert html =~ "some updated code"
    end
  end
end
