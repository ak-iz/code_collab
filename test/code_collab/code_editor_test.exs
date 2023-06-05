defmodule CodeCollab.CodeEditorTest do
  use CodeCollab.DataCase

  alias CodeCollab.CodeEditor

  describe "live_codes" do
    alias CodeCollab.CodeEditor.LiveCode

    import CodeCollab.CodeEditorFixtures

    @invalid_attrs %{code: nil}

    test "list_live_codes/0 returns all live_codes" do
      live_code = live_code_fixture()
      assert CodeEditor.list_live_codes() == [live_code]
    end

    test "get_live_code!/1 returns the live_code with given id" do
      live_code = live_code_fixture()
      assert CodeEditor.get_live_code!(live_code.id) == live_code
    end

    test "create_live_code/1 with valid data creates a live_code" do
      valid_attrs = %{code: "some code"}

      assert {:ok, %LiveCode{} = live_code} = CodeEditor.create_live_code(valid_attrs)
      assert live_code.code == "some code"
    end

    test "create_live_code/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CodeEditor.create_live_code(@invalid_attrs)
    end

    test "update_live_code/2 with valid data updates the live_code" do
      live_code = live_code_fixture()
      update_attrs = %{code: "some updated code"}

      assert {:ok, %LiveCode{} = live_code} = CodeEditor.update_live_code(live_code, update_attrs)
      assert live_code.code == "some updated code"
    end

    test "update_live_code/2 with invalid data returns error changeset" do
      live_code = live_code_fixture()
      assert {:error, %Ecto.Changeset{}} = CodeEditor.update_live_code(live_code, @invalid_attrs)
      assert live_code == CodeEditor.get_live_code!(live_code.id)
    end

    test "delete_live_code/1 deletes the live_code" do
      live_code = live_code_fixture()
      assert {:ok, %LiveCode{}} = CodeEditor.delete_live_code(live_code)
      assert_raise Ecto.NoResultsError, fn -> CodeEditor.get_live_code!(live_code.id) end
    end

    test "change_live_code/1 returns a live_code changeset" do
      live_code = live_code_fixture()
      assert %Ecto.Changeset{} = CodeEditor.change_live_code(live_code)
    end
  end
end
