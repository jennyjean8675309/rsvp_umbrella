# this function checks to see if there are any records already in the database, if there are, it will not run

christmas = Rsvp.EventQueries.create(Rsvp.Event.changeset(%Rsvp.Event{}, %{date: "2020-12-25 00:00:00", location: "Global", title: "Christmas", description: "Christmas Day"}))

graduation = Rsvp.EventQueries.create(Rsvp.Event.changeset(%Rsvp.Event{}, %{date: "2020-06-20 19:00:00", location: "Remote", title: "Lucy's Graduation Party", description: "Shhh... it's a secret!"}))

Rsvp.EventQueries.create(Rsvp.Event.changeset(%Rsvp.Event{}, %{date: "2020-09-08 12:00:00", location: "Arlington, VA", title: "Pet Parade", description: "It's a parade ... of pets!"}))

Rsvp.EventQueries.create(Rsvp.Event.changeset(%Rsvp.Event{}, %{date: "2022-02-02 07:00:00", location: "Punxsutawney, PA", title: "Groundhog's Day", description: "Join the seer of seers, the prognosticator of prognosticators..."}))

jen = Rsvp.UserQueries.create(Rsvp.User.changeset(%Rsvp.User{}, %{username: "jennyjean"}))
oz = Rsvp.UserQueries.create(Rsvp.User.changeset(%Rsvp.User{}, %{username: "ozman"}))
lucy = Rsvp.UserQueries.create(Rsvp.User.changeset(%Rsvp.User{}, %{username: "lucy"}))
ster = Rsvp.UserQueries.create(Rsvp.User.changeset(%Rsvp.User{}, %{username: "sterfry"}))

first = Rsvp.EventUserQueries.create(Rsvp.EventUser.changeset(%Rsvp.EventUser{}, %{event_id: christmas.id, user_id: jen.id, rsvp: "yes"}))
second = Rsvp.EventUserQueries.create(Rsvp.EventUser.changeset(%Rsvp.EventUser{}, %{event_id: christmas.id, user_id: oz.id, rsvp: "no"}))
Rsvp.EventUserQueries.create(Rsvp.EventUser.changeset(%Rsvp.EventUser{}, %{event_id: christmas.id, user_id: lucy.id, rsvp: "yes"}))
Rsvp.EventUserQueries.create(Rsvp.EventUser.changeset(%Rsvp.EventUser{}, %{event_id: christmas.id, user_id: ster.id, rsvp: "maybe"}))

Rsvp.MessageQueries.create(Rsvp.Message.changeset(%Rsvp.Message{}, %{content: "I wouldn't miss it!", event_user_id: first.id}))
Rsvp.MessageQueries.create(Rsvp.Message.changeset(%Rsvp.Message{}, %{content: "busy", event_user_id: second.id}))

Rsvp.EventUserQueries.create(Rsvp.EventUser.changeset(%Rsvp.EventUser{}, %{event_id: graduation.id, user_id: jen.id}))
Rsvp.EventUserQueries.create(Rsvp.EventUser.changeset(%Rsvp.EventUser{}, %{event_id: graduation.id, user_id: oz.id}))
Rsvp.EventUserQueries.create(Rsvp.EventUser.changeset(%Rsvp.EventUser{}, %{event_id: graduation.id, user_id: ster.id}))



