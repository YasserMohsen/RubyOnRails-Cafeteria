class Order < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :order_products, :dependent => :destroy
  has_many :products, through: :order_products

  after_update_commit { UserOrdersJob.perform_later self }
  after_create_commit { DashboardJob.perform_later self, "create" }

  after_initialize :set_defaults, unless: :persisted?

  def set_defaults
    self.status  ||= 'received'
    self.checked = false if self.checked.nil?
  end

  def get_total
    self.products.sum("amount * price").inspect
  end

  def get_products
    self.products
  end

  def get_amounts
    amounts=Array.new
    self.order_products.includes(:product).each do |prod|

      amounts.push(prod.amount)
    end
    return amounts
  end

end
