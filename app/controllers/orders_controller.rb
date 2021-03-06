class OrdersController < ApplicationController
  def index
    # @orders=Order.where(:user_id=>current_user.id)
    @orders=Order.where(user_id:current_user.id)

    @costs=Hash.new
    @products=Hash.new
    @prodamounts=Hash.new
    @sum=0
    Array(@orders).each do |order|
        total=0
        total=order.get_total
        prods=order.get_products
        @costs[order.id]=total
        @products[order.id]=prods
        @prodamounts[order.id]=order.get_amounts
        total=total.to_f
        @sum+=total
    end

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

  def update
    @order = Order.find(params[:id])
    @order.status = params[:status]
    if @order.save
      render json: { case: "ok", status: @order.status}
    else
      render json: { case: "error"}
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit(:notes, :room_id)
  end
end
