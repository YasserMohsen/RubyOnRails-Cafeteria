class ProductChannel < ApplicationCable::Channel
  def subscribed
     stream_from "product_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
