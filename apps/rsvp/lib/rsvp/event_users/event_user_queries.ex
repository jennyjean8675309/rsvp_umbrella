defmodule Rsvp.EventUserQueries do
    import Ecto.Query

    alias Rsvp.{Repo, EventUser}

    def create(event_user) do
        IO.puts("reached the create action in EventUserQueries")
        IO.inspect(event_user)
        Repo.insert!(event_user)
    end
end