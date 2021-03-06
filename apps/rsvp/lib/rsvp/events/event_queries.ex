defmodule Rsvp.EventQueries do
    # this module will be responsible for fetching data outside of the database
    import Ecto.Query
    # Ecto.Query allows you to write Elixir type queries to run against your database, and then turns those statements into SQL

    alias Rsvp.{Repo, Event}

    def any do
        Repo.one(from e in Event, select: count(e.id)) != 0
        # this function checks to see if there are any records in the events table by checking the count,
        # if the count is not equal to 0 (i.e. there are records in the table), then this function returns true
        # then, in the seed file, the seed data is wrapped in an unless function that will only run unless this is false
    end
    
    def get_all do
        Repo.all(from Event)
    end

    def get_all_for_location(location) do
        # here e represents an event row from the table
        query = from e in Event,
            where: e.location == ^location # here we use a ^ to tell Elixir we want the value of the argument we passed in

        Repo.all(query)
    end

    def get_by_id(id) do
        Repo.get!(Event, id)
        # this is a shortcut syntax that Ecto provides
        |> Rsvp.Repo.preload(:event_users)
        # this works in the console b/c in Rsvp.Event, a has many association between events and event users is explicitly defined
        
        
    end

    def create(event) do
        Repo.insert!(event)
    end

    def decrease_quantity(id, quantity) do
        event = Repo.get!(Event, id)
        changes = Ecto.Changeset.change event, quantity_available: event.quantity_available - String.to_integer(quantity)
        Repo.update changes
    end
end