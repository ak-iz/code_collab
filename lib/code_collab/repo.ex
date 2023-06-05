defmodule CodeCollab.Repo do
  use Ecto.Repo,
    otp_app: :code_collab,
    adapter: Ecto.Adapters.Postgres
end
