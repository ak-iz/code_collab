defmodule CodeCollabWeb.LiveCodeLive.FormComponent do
  use CodeCollabWeb, :live_component

  alias CodeCollab.CodeEditor

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage live_code records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="live_code-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:code]} type="text" label="Code" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Live code</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{live_code: live_code} = assigns, socket) do
    changeset = CodeEditor.change_live_code(live_code)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"live_code" => live_code_params}, socket) do
    changeset =
      socket.assigns.live_code
      |> CodeEditor.change_live_code(live_code_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"live_code" => live_code_params}, socket) do
    save_live_code(socket, socket.assigns.action, live_code_params)
  end

  defp save_live_code(socket, :edit, live_code_params) do
    case CodeEditor.update_live_code(socket.assigns.live_code, live_code_params) do
      {:ok, live_code} ->
        notify_parent({:saved, live_code})

        {:noreply,
         socket
         |> put_flash(:info, "Live code updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_live_code(socket, :new, live_code_params) do
    case CodeEditor.create_live_code(live_code_params) do
      {:ok, live_code} ->
        notify_parent({:saved, live_code})

        {:noreply,
         socket
         |> put_flash(:info, "Live code created successfully")
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
