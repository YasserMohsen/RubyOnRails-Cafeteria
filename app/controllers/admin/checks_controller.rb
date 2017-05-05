class Admin::ChecksController < Admin::AdminController
  semantic_breadcrumb "Checks", :admin_checks_path

  def index
    @data = {}
    User.includes(:orders => :products).all.each do |user|
      total = 0
      orders = {}
      user.orders.each do |order|
        orders[order.id] = order
        total += order.get_total.to_i
      end
      @data[user.id] = {user: user, total: total, orders: orders}
    end
    puts @data.inspect
  end
end
