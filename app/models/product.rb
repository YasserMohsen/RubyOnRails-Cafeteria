class Product < ApplicationRecord
  belongs_to :category
  has_many :order_products #, :dependent => destroy
  has_many :orders, through: :order_products
  has_attached_file :picture
  validates_attachment :picture,
                       content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
end
