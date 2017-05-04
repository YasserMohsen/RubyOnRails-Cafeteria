var cart_products = {};

App.product = App.cable.subscriptions.create("ProductChannel", {
    connected: function () {
        console.log("connected")
    },

    disconnected: function () {
        console.log("disconnected")
    },

    received: function (data) {
        console.log(data);
        if(data.action === "create"){
            console.log("#category_" + data.product.category_id)
            $("#category_" + data.product.category_id).append(data.html);
        }else if (data.action === "destroy"){
            $("#product_" + data.product.id).remove();
        }
    }
});

$(document).on("click", ".add-to-cart", function () {
    var button = $(this);
    var product = {
        id : button.data("id"),
        category_id : button.data("category_id"),
        price : button.data("price")
    };
    console.log(product)
});