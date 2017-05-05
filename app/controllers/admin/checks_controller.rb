class Admin::ChecksController < Admin::AdminController
  semantic_breadcrumb "Checks", :admin_checks_path

  def index
     filter = {}

     if params.key? :filter
       if params[:filter].key? :user
         filter[:user_id] = params[:filter].fetch(:user).to_i if params[:filter].fetch(:user).to_i > 0
       end
     end

    @data = {}
    Order.joins(:user).select('orders.*, users.name').where(filter).group_by(&:name).each do |username,orders|
      total = 0
      user_orders = {}
      orders.each do |order|
        total += order.get_total.to_i
        user_orders[order.id] = order
      end
      @data[username] = {total: total, orders: user_orders}
    end
  end
end
