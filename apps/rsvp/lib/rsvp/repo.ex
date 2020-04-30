defmodule Rsvp.Repo do
    use Ecto.Repo, 
        otp_app: :rsvp,
        adapter: Ecto.Adapters.Postgres

    # alias Rsvp.{Repo, Events}

    # import Ecto.Query
    # # Ecto.Query allows you to write Elixir type queries to run against your database, and then turns those statements into SQL
    
    # def get_all do
    #     Repo.all(from Events)
    # end
end