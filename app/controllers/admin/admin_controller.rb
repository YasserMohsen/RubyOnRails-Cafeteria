class Admin::AdminController < ActionController::Base
  layout 'admin'
  protect_from_forgery with: :exception
  semantic_breadcrumb "Admin", :root_path
end
