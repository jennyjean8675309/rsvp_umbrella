defmodule RsvpWeb.AuthorizedPlug do
    import Plug.Conn
    import Phoenix.Controller

    def init(opts) do 
        opts
    end

    def call(conn, _) do 
        user_name = conn.cookies["user_name"]

        authorized_user(conn, user_name)
    end

    defp authorized_user(conn, nil) do
        conn
        |> redirect(to: "/login")
        |> halt
        # the halt command tells Elixir not to run any plugs at this point
    end

    defp authorized_user(conn, _) do
        conn
    end
end