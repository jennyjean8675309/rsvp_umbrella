defmodule RsvpWeb.EventController do
    use RsvpWeb, :controller

    # plug RsvpWeb.AuthorizedPlug when action in [:create]

    # %{"id" => id} syntax - the second argument to the show action is params, and here we are using pattern matching to create a struct which matches "id" to the id passed in to params
    def show(conn, %{"id" => id}) do
        # if there is a leading underscore it indicates that this parameter is not used in this function, and helps prevent warnings when compiling
        event = Rsvp.EventQueries.get_by_id(id)
        # |> IO.inspect() # this line preserves the data received from the terminal and does not alter it (i.e. event will still hold the data)
        
        render conn, "details.html", event: event
        # render takes in three arguments, conn, a template name, and the data to be rendered
    end

    def list(conn, _params) do
        events = Rsvp.EventQueries.get_all
        render conn, "list.html", events: events
    end

    def create(conn, _params) do
        changeset = Rsvp.Event.changeset(%Rsvp.Event{}, %{})
        # using @changeset in the form did not work (I had to use @conn instead???)
        # b/c we are using a form_for helper, we need to define an empty changeset here
        render conn, "create.html", changeset: changeset
    end

    def add(conn, params) do
        IO.inspect(params)
        # this is a form of debugging - it outputs params to the terminal for us
        events = Map.update!(params, "date", fn d -> d <> ":00" end)
        %{id: id} = Rsvp.Event.changeset(%Rsvp.Event{}, events)
        |> Rsvp.EventQueries.create()
        # b/c the create action returns a newly created event, you can use pattern matching to set the id ( %{id: id} ), and then use that for the redirect
        
        redirect conn, to: Routes.event_path(conn, :show, id)
    end

    def reserve(conn, %{"id" => id, "reservation" => %{ "quantity" => quantity}}) do 
        {:ok, event} = Rsvp.EventQueries.decrease_quantity(id, quantity)
        RsvpWeb.EventChannel.send_update(event)
        redirect conn, to: Routes.event_path(conn, :show, id)
    end

    def rsvp(conn, %{"id" => id, "rsvp" => %{"rsvp" => rsvp}}) do
        user_name = Plug.Conn.fetch_cookies(conn).cookies["user_name"]
        current_user = Rsvp.UserQueries.find_by_user_name(user_name)

        changeset = Rsvp.EventUser.changeset(%Rsvp.EventUser{}, %{rsvp: rsvp, event_id: id, user_id: current_user.id})
        new_rsvp = Rsvp.EventUserQueries.create(changeset)

        RsvpWeb.EventUserChannel.send_update(new_rsvp)

        redirect conn, to: Routes.event_path(conn, :show, id)
    end
end