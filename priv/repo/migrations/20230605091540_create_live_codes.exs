defmodule CodeCollab.Repo.Migrations.CreateLiveCodes do
  use Ecto.Migration

  def change do
    create table(:live_codes) do
      add :code, :string

      timestamps()
    end
  end
end
