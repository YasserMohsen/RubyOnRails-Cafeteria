class ProductBroadcastJob < ApplicationJob
  queue_as :default

  def perform(product, action)
    if action == "create" && product.availability == false
      return
    end
    response = {action: action, product: product}
    unless action == "destroy"
      response[:html] = render_product(product)
    end
    ActionCable.server.broadcast 'product_channel', response
  end

  private
  def render_product(product)
    ApplicationController.renderer.render(partial: 'orders/product', locals: {product: product})
  end
end
