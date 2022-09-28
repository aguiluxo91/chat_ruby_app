import consumer from "channels/consumer"


const scroll_bottom = function() {
  messages.scrollTo(0, messages.scrollHeight)
}

consumer.subscriptions.create("ChatroomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    document.querySelector('#message-container').innerHTML += data.mod_message
    scroll_bottom()
  }
});
