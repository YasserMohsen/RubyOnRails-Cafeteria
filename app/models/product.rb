class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true

  belongs_to :category
  has_many :order_products , :dependent => :destroy
  has_many :orders, through: :order_products

  has_attached_file :picture,
                    styles: {thumb: ["64x64#", :png]},
                    default_url: 'default-image-:style.png'
  validates_attachment :picture, presence: true,
                       content_type: {content_type: ["image/jpeg", "image/gif", "image/png"]},
                       size: {in: 0..500.kilobytes}

  after_create_commit {ProductBroadcastJob.perform_later self, "create"}
  after_update_commit {ProductBroadcastJob.perform_later self, "update"}
  before_destroy {ProductBroadcastJob.perform_later self, "destroy"}
end
