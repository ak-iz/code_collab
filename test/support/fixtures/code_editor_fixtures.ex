defmodule CodeCollab.CodeEditorFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CodeCollab.CodeEditor` context.
  """

  @doc """
  Generate a live_code.
  """
  def live_code_fixture(attrs \\ %{}) do
    {:ok, live_code} =
      attrs
      |> Enum.into(%{
        code: "some code"
      })
      |> CodeCollab.CodeEditor.create_live_code()

    live_code
  end
end
