class OrdersController < ApplicationController
  def index
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

    if !@order.errors.any? && @order.save
      params[:order][:products].each do |product_id, amount|
        @product = OrderProduct.new(order_id: @order.id, product_id: product_id, amount: amount)
        @product.save
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
