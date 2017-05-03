class Product < ApplicationRecord
  belongs_to :category
  has_many :order_products #, :dependent => destroy
  has_many :orders, through: :order_products
  has_attached_file :picture,
                    styles: { thumb: ["64x64#", :png]}
  validates_attachment :picture,  presence: true,
                       content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
                       size: { in: 0..500.kilobytes }
end
