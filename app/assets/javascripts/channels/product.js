var refreshData = function () {
    // this. refer to Cart scope, because i used callback.call(this)
    $("#cart").html(this.render());
    $("#total").text(this.getTotal())
};

var removeElement = function (target) {
    target.animate({opacity: 0},500, function () {
        target.remove();
    });
};

var Cart = function () {
    this.list = {}
};

Cart.prototype.get = function (id) {
    return (id in this.list) ? this.list[id] : {};
};

Cart.prototype.add = function (product,callback) {
    if (product.id in this.list) {
        this.list[product.id].quantity += 1;
    } else {
        this.list[product.id] = {quantity: 1, product: product};
    }
    if (callback && typeof(callback) === "function") {
        callback.call(this);
    }
};

Cart.prototype.update = function (id, new_product, callback) {
    if (id in this.list) {
        this.list[id].product = new_product;
        if (callback && typeof(callback) === "function") {
            callback.call(this);
        }
    }
};

Cart.prototype.updateQuantity = function (id, action, callback) {
    if (id in this.list) {
        if (action === 'inc') {
            this.list[id].quantity += 1;
        }else if  (action === 'dec') {
            this.list[id].quantity -= 1;
            if (this.list[id].quantity < 1) {
                this.list[id].quantity = 1;
            }
        }
        if (callback && typeof(callback) === "function") {
            callback.call(this);
        }
    }
};

Cart.prototype.remove = function (id,callback) {
    if (id in this.list) {
        delete this.list[id];
        if (callback && typeof(callback) === "function") {
            callback.call(this);
        }
    }
};

Cart.prototype.getTotal = function () {
    var total = 0;
    for (var product in this.list) {
        total += this.list[product].quantity * this.list[product].product.price;
    }
    return total;
};

Cart.prototype.render = function () {
    html = "";
    if (Object.keys(this.list).length === 0) {
        html += "<tr><td colspan='4'>Empty ...</td></tr>";
    }else{
        for (var product in this.list) {
            var hidden = "<input type='hidden' name='order[products][" + product +"]' value='" + this.list[product].quantity + "' />";
            html += "<tr>";
            html += "<td>" + this.list[product].product.name + "</td>";
            html += "<td><i data-id='" + product +"' data-action='dec' class='minus red icon change-quantity'></i> <span class='ui circular label'>" + this.list[product].quantity + "</span> <i data-id='" + product +"' data-action='inc' class='plus green icon change-quantity'></i></td>";
            html += "<td>" + this.list[product].product.price + "</td>";
            html += "<td><i data-id='" + product +"' class='large remove red icon remove_line'></i> " + hidden + "</td>";
            html += "</tr>";
        }
    }
    return html;
};

var cart = new Cart();



App.product = App.cable.subscriptions.create("ProductChannel", {
    connected: function () {
        console.log("ProductChannel connected")
    },
    disconnected: function () {
        console.log("ProductChannel disconnected")
    },
    received: function (data) {
        console.log("ProductChannel received")
        if (data.action === "create") {
            //if (data.product.availability === true) {
                $("#category_" + data.product.category_id).append(data.html);
            //}
        } else if (data.action === "update") {
            if (data.product.availability === false) {
                $target = $("#product_" + data.product.id);
                removeElement($target);
                cart.remove(data.product.id,refreshData);
            } else {
                $target = $("#product_" + data.product.id);
                if ($target.length) {
                    removeElement($target);
                }
                $("#category_" + data.product.category_id).append(data.html)
                cart.update(data.product.id,data.product,refreshData);
            }
        } else if (data.action === "destroy") {
            $target = $("#product_" + data.product.id);
            removeElement($target);
            cart.remove(data.product.id,refreshData);
        }
    }
});


$(document).ready(function () {
    $(document).on("click", ".add-to-cart", function () {
        var button = $(this);
        var product = {
            id: button.data("id"),
            name: button.data("name"),
            category_id: button.data("category_id"),
            price: button.data("price")
        };
        cart.add(product,refreshData);
    });
    $(document).on('click','.remove_line',function () {
        var product_id = $(this).data("id");
        cart.remove(product_id,refreshData);
    });
    $(document).on("click",".change-quantity",function () {
        var action = $(this).data("action");
        var id = $(this).data("id");
        cart.updateQuantity(id,action,refreshData);
    })
});
