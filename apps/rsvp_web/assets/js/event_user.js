import socket from './socket'

(function() {
    let id = document.getElementById('id').dataset.id

    if (!id)
        return;

    let channel = socket.channel("event_user:" + id, {});

    channel.on("update_rsvp", rsvp => {
        console.log("Update event user", rsvp)
        let text = rsvp["rsvp"]
        let span = document.getElementById(text)
        let rsvp_header = document.getElementById("rsvp")
        span.innerText = parseInt(span.innerText) + 1
        rsvp_header.innerText = parseInt(rsvp_header.innerText) + 1
    })

    channel.join()
        .receive("ok", resp => { console.log("Joined successfully event:" + id, resp)})
        .receive("error", resp => { console.log("Unable to join", resp)})
})();