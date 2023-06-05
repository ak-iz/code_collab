defmodule CodeCollabWeb.LiveCodeLive.Index do
  use CodeCollabWeb, :live_view

  alias CodeCollab.CodeEditor
  alias CodeCollab.CodeEditor.LiveCode

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :live_codes, CodeEditor.list_live_codes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Live code")
    |> assign(:live_code, CodeEditor.get_live_code!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Live code")
    |> assign(:live_code, %LiveCode{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Live codes")
    |> assign(:live_code, nil)
  end

  @impl true
  def handle_info({CodeCollabWeb.LiveCodeLive.FormComponent, {:saved, live_code}}, socket) do
    {:noreply, stream_insert(socket, :live_codes, live_code)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    live_code = CodeEditor.get_live_code!(id)
    {:ok, _} = CodeEditor.delete_live_code(live_code)

    {:noreply, stream_delete(socket, :live_codes, live_code)}
  end
end
