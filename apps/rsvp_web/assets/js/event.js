import socket from './socket';

(function() {
    // let id = $('#id').data('id');
    // this line is using jQuery to fetch an id from our template

    let id = document.getElementById('id').dataset.id
    let quantity = document.getElementsByClassName('quantity')[0]

    if (!id)
        return;

    let channel = socket.channel("event:" + id, {});

    channel.on("update_quantity", event => {
        console.log("Update", event)
        quantity.innerText = event.quantity
    })

    // channel.on("update_rsvp", event => {
    //     console.log("Update", event)
    // })

    channel.join()
        .receive("ok", resp => { console.log("Joined successfully event:" + id, resp)})
        .receive("error", resp => { console.log("Unable to join", resp)})
})();