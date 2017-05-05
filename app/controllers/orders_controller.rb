class OrdersController < ApplicationController
  def index
    # @orders=Order.where(:user_id=>current_user.id)
    @orders=Order.where(user_id:current_user.id)
    @costs=Hash.new
    @products=Array.new
    Array(@orders).each do |order|
        total=0
        prodids=Array.new
        prodamounts=OrderProduct.where(order_id:order['id']).select([:product_id,:amount])
        prodamounts.each do |product|
          prodids.push(product.product_id)
        end
        prods=Product.where(id: prodids).select([:id,:price,:name])
        prods.each do |pr|
        prodamounts.each do |am|
            if am.product_id==pr.id
              amount=am.amount*pr.price
              total+=amount

              pr.class_eval do
                attr_accessor :amount
              end
              pr.amount=am.amount

            end
          end
        end
        @products.push(prods)
        @costs[order.id]=total
    end



    # @orders=Order.
  end
  def new
    @order = Order.new
    @categories = Category.all
  end
end
