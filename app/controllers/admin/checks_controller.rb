class Admin::ChecksController < Admin::AdminController
  semantic_breadcrumb "Checks", :admin_checks_path

  def index
    @data = {}

    @users = User.includes(:orders => :products).all

    @users.each do |user|
      user.orders.each do |order|
        puts "total"
        puts order.get_total
        order.products.each do |product|
          puts "name"
          puts product.name.inspect
        end
      end
    end

  end
end
