class DashboardJob < ApplicationJob
  queue_as :default

  def perform(order, action)
    response = {action: action, order: order}
    unless action == "destroy"
      response[:html] = render_order(order)
    end
    ActionCable.server.broadcast 'dashboard_channel', response
  end

  private
  def render_order(order)
    ApplicationController.renderer.render(partial: 'admin/dashboard/order', locals: {order: order})
  end
end