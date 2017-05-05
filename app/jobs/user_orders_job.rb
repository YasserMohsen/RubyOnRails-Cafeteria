class UserOrdersJob < ApplicationJob
  queue_as :default

  def perform(data)
    # Do something later
     ActionCable.server.broadcast 'order_channel', data: data
  end
end
