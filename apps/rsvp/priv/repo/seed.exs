# this function checks to see if there are any records already in the database, if there are, it will not run
unless Rsvp.EventQueries.any do
    Rsvp.EventQueries.create(Rsvp.Events.changeset(%Rsvp.Events{}, %{date: "2020-12-25 00:00:00", location: "Global", title: "Christmas", description: "Christmas Day"}))
end

