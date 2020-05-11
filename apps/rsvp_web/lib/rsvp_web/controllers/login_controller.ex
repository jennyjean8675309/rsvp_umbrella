defmodule RsvpWeb.LoginController do
    use RsvpWeb, :controller

    def index(conn, _) do
        render conn, "login.html"
    end

    def login(conn, %{"login" => %{"username" => name}}) do
        expiration = 60*60*24*7
        # cookies need an expiration, this tells it not to expire for a full week
        conn
        |> Plug.Conn.put_resp_cookie("user_name", name, max_age: expiration)
        |> redirect(to: "/")
    end

    def logout(conn, _params) do
        conn
        |> Plug.Conn.delete_resp_cookie("user_name")
        |> redirect(to: "/")
    end
end