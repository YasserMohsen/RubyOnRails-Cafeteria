class Order < ApplicationRecord
  belongs_to :user
  belongs_to :room
  #has_many :order_products, :dependent => destroy
  has_many :products, through: :order_products
end
