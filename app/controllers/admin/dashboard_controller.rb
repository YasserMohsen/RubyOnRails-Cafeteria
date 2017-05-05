class Admin::DashboardController < Admin::AdminController
  def index
    @orders = Order.where(checked: false, status: ['received', 'processing'])
  end
end
