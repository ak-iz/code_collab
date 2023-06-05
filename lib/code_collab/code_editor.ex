defmodule CodeCollab.CodeEditor do
  @moduledoc """
  The CodeEditor context.
  """

  import Ecto.Query, warn: false
  alias CodeCollab.Repo

  alias CodeCollab.CodeEditor.LiveCode

  @doc """
  Returns the list of live_codes.

  ## Examples

      iex> list_live_codes()
      [%LiveCode{}, ...]

  """
  def list_live_codes do
    Repo.all(LiveCode)
  end

  @doc """
  Gets a single live_code.

  Raises `Ecto.NoResultsError` if the Live code does not exist.

  ## Examples

      iex> get_live_code!(123)
      %LiveCode{}

      iex> get_live_code!(456)
      ** (Ecto.NoResultsError)

  """
  def get_live_code!(id), do: Repo.get!(LiveCode, id)

  @doc """
  Creates a live_code.

  ## Examples

      iex> create_live_code(%{field: value})
      {:ok, %LiveCode{}}

      iex> create_live_code(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_live_code(attrs \\ %{}) do
    %LiveCode{}
    |> LiveCode.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a live_code.

  ## Examples

      iex> update_live_code(live_code, %{field: new_value})
      {:ok, %LiveCode{}}

      iex> update_live_code(live_code, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_live_code(%LiveCode{} = live_code, attrs) do
    live_code
    |> LiveCode.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a live_code.

  ## Examples

      iex> delete_live_code(live_code)
      {:ok, %LiveCode{}}

      iex> delete_live_code(live_code)
      {:error, %Ecto.Changeset{}}

  """
  def delete_live_code(%LiveCode{} = live_code) do
    Repo.delete(live_code)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking live_code changes.

  ## Examples

      iex> change_live_code(live_code)
      %Ecto.Changeset{data: %LiveCode{}}

  """
  def change_live_code(%LiveCode{} = live_code, attrs \\ %{}) do
    LiveCode.changeset(live_code, attrs)
  end
end
