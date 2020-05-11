defmodule RsvpWeb.EventView do
    use RsvpWeb, :view

    # this function could be refactored by mapping over (or reducing) event_users into a histogram
    def rsvp_count(event_users) do
        total_count = Kernel.length(event_users)

        yes_count = Enum.filter(event_users, fn r -> r.rsvp == "yes" end)
        |> Kernel.length()

        no_count = Enum.filter(event_users, fn r -> r.rsvp == "no" end)
        |> Kernel.length()

        maybe_count = Enum.filter(event_users, fn r -> r.rsvp == "maybe" end)
        |> Kernel.length()

        %{total: total_count, yes: yes_count, no: no_count, maybe: maybe_count}
    end
end