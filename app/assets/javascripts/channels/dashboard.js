App.dashboard = App.cable.subscriptions.create("DashboardChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
      console.log("Dashboard connected")
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
      console.log("Dashboard disconnected")
  },

  received: function(data) {
      console.log("Dashboard: New Order Received")
    // Called when there's incoming data on the websocket for this channel
      if(data.action == "create"){
          console.log("create new order notificaton")
          $("#dashboard").append(data.html);
      }
  }
});
