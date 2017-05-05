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

  def create
    @order = Order.new(order_params)
    @order.user = current_user

    unless params[:order].key?(:products)
      @order.errors.add(:base, :not_valid, message: "Please select at least one product")
    end

    if !@order.errors.any?
      Order.transaction do
        @order.save!
        params[:order][:products].each do |product_id, amount|
              @product = OrderProduct.new(order_id: @order.id, product_id: product_id, amount: amount)
              @product.save!
        end
      end
      redirect_to root_path, notice: 'Order was successfully created.'
    else
      @categories = Category.all
      render :new
    end

  end

  private

  def order_params
    params.require(:order).permit(:notes, :room_id, :user_id)
  end

end
