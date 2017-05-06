class Admin::OrdersController < Admin::AdminController
  semantic_breadcrumb "Rooms", :admin_rooms_path

  def new
    semantic_breadcrumb "Create", new_admin_room_path
    @order = Order.new
    @categories = Category.all
  end

  def create
    @order = Order.new(order_params)

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
      redirect_to admin_path, notice: 'Order was successfully created.'
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
