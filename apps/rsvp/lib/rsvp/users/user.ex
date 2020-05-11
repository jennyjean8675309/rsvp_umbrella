defmodule Rsvp.User do
    use Ecto.Schema

    import Ecto.Changeset

    schema "users" do
        field :username, :string

        many_to_many :events, Rsvp.Event, join_through: "event_users"

        timestamps()
    end

    def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:username])
        |> validate_required([:username])
        |> unique_constraint(:username)
    end
end