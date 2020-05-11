defmodule Rsvp.MessageQueries do
    import Ecto.Query

    alias Rsvp.{Repo, Message}

    def create(message) do
        Repo.insert!(message)
    end
end