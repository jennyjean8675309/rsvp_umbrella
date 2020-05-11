defmodule Rsvp.Event do
    use Ecto.Schema

    import Ecto.Changeset

    schema "events" do
        field :title, :string
        field :location, :string
        field :date, :naive_datetime
        field :description, :string
        field :quantity_available, :integer, default: 25

        has_many :event_users, Rsvp.EventUser
        many_to_many :users, Rsvp.User, join_through: "event_users"

        timestamps()
    end

    # @required_fields ~w(location, date)a
    # # these are word list shortcuts ~w - by specifying an a at the end, we are telling Elixir to make these atoms - was not successful in getting this syntax to work
    # @optional_fields ~w(description)a

    def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:title, :location, :date, :description])
        |> validate_required([:title, :location, :date])
        # cast is a part of the Changeset module - cast 'casts' values to their correct type - it automagically changes the datatype for you
        # |> validate_change(:date, &must_be_future/2)
    end

    # ********** Custom Validations **********

    # This is how you would specify that a date must be in the future (won't implement in my own project b/c Ecto.DateTime is deprecated and does not work with version 1.5.1)
    
    # defp must_be_future(_, value) do
    #     Ecto.DateTime.compare(value, Ecto.DateTime.utc)
    #     |> get_error
    # end

    # defp get_error(comparison) when comparison == :lt, do: [date: "Cannot be in the past"]
    
    # defp get_error(_), do: []
end