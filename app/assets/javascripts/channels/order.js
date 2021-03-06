App.order = App.cable.subscriptions.create("OrderChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    $("#orderstatus"+ data.data.id).html(data.data.status);
    $("#cancelbtn"+ data.data.id).remove()

    // Called when there's incoming data on the websocket for this channel
  }
});
