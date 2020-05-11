defmodule RsvpWeb.EventUserChannel do
    use Phoenix.Channel

    def join("event_user:" <> event_id, _message, socket) when event_id <= 0 do
        {:error, %{reason: "invalid event id"}}
    end

    def join("event_user:" <> event_id, _message, socket) do
        {:ok, socket}
    end

    def send_update(event_user) do
        payload = %{
            "rsvp" => event_user.rsvp
        }
        |> IO.inspect()
        
        RsvpWeb.Endpoint.broadcast("event_user:#{event_user.event_id}", "update_rsvp", payload)
    end
end