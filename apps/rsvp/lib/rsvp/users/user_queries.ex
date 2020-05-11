defmodule Rsvp.UserQueries do
    import Ecto.Query

    alias Rsvp.{Repo, User}

    def any do
        Repo.one(from u in User, select: count(u.id)) != 0
    end

    def create(user) do
        Repo.insert!(user)
    end

    def find_by_user_name(user_name) do
        Repo.get_by!(User, username: user_name)
    end
end