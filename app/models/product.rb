class Product < ApplicationRecord
  belongs_to :category
  has_many :order_products #, :dependent => destroy
  has_many :orders, through: :order_products
end
