class OrdersController < ApplicationController
  def index
  end
  def new
    @order = Order.new
    @categories = Category.all
  end
end
