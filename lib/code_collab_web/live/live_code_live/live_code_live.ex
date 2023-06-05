defmodule CodeCollabWeb.LiveCodeLive do
  use CodeCollabWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, code: "")}
  end

  def handle_event("handleKeypress", %{"code" => code}, socket) do
    {:noreply, assign(socket, code: code)}
  end

  def handle_info({:phx_keydown, "handleKeypress", %{"code" => code}}, socket) do
    {:noreply, assign(socket, code: code)}
  end
end
