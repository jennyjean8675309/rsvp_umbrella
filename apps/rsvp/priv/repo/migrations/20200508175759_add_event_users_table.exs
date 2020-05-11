defmodule Rsvp.Repo.Migrations.AddEventUsersTable do
  use Ecto.Migration

  def change do
    create table(:event_users) do
      add :rsvp, :string, default: "no"
      add :event_id, references(:events)
      add :user_id, references(:users)

      timestamps()
    end
  end
end
