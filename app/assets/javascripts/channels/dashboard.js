App.dashboard = App.cable.subscriptions.create("DashboardChannel", {
  connected: function() {
      console.log("Dashboard connected")
  },

  disconnected: function() {
      console.log("Dashboard disconnected")
  },

  received: function(data) {
      console.log("Dashboard Channel: Received Data")
      if(data.action == "create"){
          console.log("create new order notificaton")
          $("#dashboard").append(data.html);
      }
  }
});

$(function () {
    $(".dashboard_order_button").click(function () {
        var my_order = $(this)
        var statuses = ["received", "processing", "out for delivery"]
        var i = statuses.indexOf(my_order.data("status"))
        if(i >= 0) {
            var new_status = statuses[i + 1] || null
        }
        if(new_status) {
            var order = {
                id: my_order.data("id"),
                status: new_status
            }
            $.ajax({
                type: "PUT",
                url: "/orders/" + order.id,
                data: order,
                success: function (data) {
                    console.log(data)
                    if (data.case == "ok") {
                        if (data.status == "processing") {
                            my_order.html("Finish")
                            my_order.data("status", data.status)
                            my_order.removeClass("red").addClass("green")
                        }
                        if (data.status == "out for delivery") {
                            $("#dashboard_order_"+order.id).remove()
                        }
                    }
                }
            })
        }
    });
});