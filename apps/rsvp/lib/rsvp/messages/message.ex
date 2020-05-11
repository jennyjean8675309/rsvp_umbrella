defmodule Rsvp.Message do
    use Ecto.Schema

    import Ecto.Changeset

    schema "messages" do
        field :content, :string, size: 200
        
        belongs_to :event_user, Rsvp.EventUser

        timestamps()
    end

    def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:content, :event_user_id])
        |> validate_required([:content, :event_user_id])
    end
end