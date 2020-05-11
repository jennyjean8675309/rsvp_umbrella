defmodule Rsvp.Repo.Migrations.AddMessagesTable do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :content, :string
      add :event_user_id, references(:event_users)

      timestamps()
    end
  end
end
