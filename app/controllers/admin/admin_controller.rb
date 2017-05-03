class Admin::AdminController < ActionController::Base
  layout 'admin'
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  before_action :is_admin?
  semantic_breadcrumb "Admin", :admin_path

  def is_admin?
    unless current_user.is_admin
      redirect_to root_path, notice: 'Access denied.'
    end
  end
end
