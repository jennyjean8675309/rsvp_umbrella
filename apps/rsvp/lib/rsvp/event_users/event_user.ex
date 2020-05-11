defmodule Rsvp.EventUser do
    use Ecto.Schema

    import Ecto.Changeset

    schema "event_users" do
        field :rsvp, :string

        belongs_to :event, Rsvp.Event
        belongs_to :user, Rsvp.User

        has_many :messages, Rsvp.Message

        timestamps()
    end

    def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:rsvp, :event_id, :user_id])
        # |> validate_required([:rsvp, :event_id, :user_id])
    end
end