class Order < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :order_products, :dependent => :destroy
  has_many :products, through: :order_products

  def get_total
    self.products.sum("amount * price").inspect
  end

end
