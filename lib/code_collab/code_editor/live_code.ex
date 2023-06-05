defmodule CodeCollab.CodeEditor.LiveCode do
  use Ecto.Schema
  import Ecto.Changeset

  schema "live_codes" do
    field :code, :string

    timestamps()
  end

  @doc false
  def changeset(live_code, attrs) do
    live_code
    |> cast(attrs, [:code])
    |> validate_required([:code])
  end
end
